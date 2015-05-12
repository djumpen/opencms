<?php 
/******************************************************
 * @package Pav blog module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

/**
 * class ControllerpavblogBlog 
 */
	class ControllerpavblogBlog extends Controller {
		private $mparams = '';
		public function preload(){
			$this->language->load('module/pavblog');
		
			$this->load->model("pavblog/blog");
			$this->load->model("pavblog/comment");
			$mparams = $this->config->get( 'pavblog' );
			$default = $this->model_pavblog_blog->getDefaultConfig();
			
			$mparams = !empty($mparams)?$mparams:array();

			if( $mparams ){
				$mparams =  array_merge( $default,$mparams);
			}else{
				$mparams = $default;
			}
			$config = new Config();
			if( $mparams ){
				foreach( $mparams as $key => $value ){
					$config->set( $key, $value );
				}
			}
			$this->mparams = $config; 

			
			if( $this->mparams->get('comment_engine') == '' ||  $this->mparams->get('comment_engine') == 'local' ) {
			}else {			
				$this->mparams->set( 'blog_show_comment_counter', 0 );	
				$this->mparams->set( 'cat_show_comment_counter', 0 );	
			}	
		

			if( !defined("_PAVBLOG_MEDIA_") ){
				define("_PAVBLOG_MEDIA_",true);
			}
		}
		
		public function getParam( $key, $value='' ){
			return  $this->mparams->get( $key, $value );
		}
		
		/**
		 * get module object
		 *
		 */
		public function getModel( $model='blog' ){
			return $this->{"model_pavblog_{$model}"};
		}
		
		/**
		 *
	     * index action
		 */
		public function index() {  
		
			$this->preload();
			$category_id = 0;
			$this->load->model('tool/image'); 
			
			
			$this->data['breadcrumbs'] = array();
			
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home'),
				'separator' => false
			);
		 
			
			
		
			$this->request->get['id'] = isset($this->request->get['id'])?$this->request->get['id']:0;
			$blog_id = $this->request->get['id'];
			$blog = $this->getModel()->getInfo( $blog_id );
			$this->load->model('pavblog/category');
			
			$users = $this->model_pavblog_category->getUsers();

			

			$this->data['config']	 = $this->mparams; 
			if ($blog) {
			
				$category_id = $blog['category_id'];
				$title = $blog['meta_title'] ? $blog['meta_title']:$blog['title']; 
				$this->document->setTitle( $title ); 
				$this->document->setDescription( $blog['meta_description'] );
				$this->document->setKeywords( $blog['meta_keyword'] );
				
				$this->data['breadcrumbs'][] = array(
					'text'      => $blog['category_title'],
					'href'      => $this->url->link('pavblog/category', 'id=' .  $category_id),      		
					'separator' => $this->language->get('text_separator')
				);	
				$this->data['breadcrumbs'][] = array(
					'text'      => $blog['title'],
					'href'      => $this->url->link('pavblog/blog', 'id=' .  $blog_id),      		
					'separator' => $this->language->get('text_separator')
				);		
							
				$this->data['heading_title'] = $blog['title'];
				
				$this->data['button_continue'] = $this->language->get('button_continue');
				
				$this->data['description'] = html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
				$this->data['content'] = html_entity_decode($blog['content'], ENT_QUOTES, 'UTF-8');
				$this->data['entry_captcha'] = $this->language->get('entry_captcha');
				$this->data['continue'] = $this->url->link('common/home');
				if (isset($this->error['captcha'])) {
					$this->data['error_captcha'] = $this->error['captcha'];
				} else {
					$this->data['error_captcha'] = '';
				}


				$type = array('l'=>'thumb_large','s'=>'thumb_small');
				$imageType = isset($type[$this->mparams->get('blog_image_type')])?$type[$this->mparams->get('blog_image_type')]:'thumb_xsmall';
				
				if( $blog['image'] ){	
					$blog['thumb_large'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_lwidth'), $this->mparams->get('general_lheight'),'w');
					$blog['thumb_small'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_swidth'), $this->mparams->get('general_sheight'),'w' );
					$blog['thumb_xsmall'] = $this->model_tool_image->resize($blog['image'],$this->mparams->get('general_xwidth'), $this->mparams->get('general_xheight') ,'w');
				}else {
					$blog['thumb_large'] = '';
					$blog['thumb_small'] = '';
					$blog['thumb_xsmall'] = '';
				}
				
				$blog['thumb'] = $blog[$imageType];
				
				$blog['description'] = html_entity_decode( $blog['description'] );
				$blog['author'] = isset($users[$blog['user_id']])?$users[$blog['user_id']]:$this->language->get('text_none_author');
				$blog['category_link'] =  $this->url->link( 'pavblog/category', "id=".$blog['category_id'] );
				$blog['comment_count'] =  $this->getModel('comment')->countComment( $blog['blog_id'] );
				$blog['link'] =  $this->url->link( 'pavblog/blog','id='.$blog['blog_id'] );

				if (isset($this->request->post['captcha'])) {
					$this->data['captcha'] = $this->request->post['captcha'];
				} else {
					$this->data['captcha'] = '';
				}	

				
				$this->data['comment_action'] = $this->url->link( 'pavblog/blog/comment','id='.$blog['blog_id'] );
				$this->data['blog'] = $blog;
				$this->data['samecategory'] = $this->getModel()->getSameCategory( $blog['category_id'], $blog['blog_id'] );
				$this->data['social_share'] =  '';
				$data = array(
					'filter_category_id' => '',
					'filter_tag'		=> $blog['tags'],
					'not_in'           => $blog['blog_id'],
					'sort'               => 'created',
					'order'              => 'DESC',
					'start'              => 0,
					'limit'              => 10
				);

				$related = $this->getModel('blog')->getListBlogs(  $data );
			
				
				$this->data['related'] = $related;
				
				$ttags = explode( ",",$blog['tags']);
				$tags  = array();
				
				foreach( $ttags as $tag ){
					$tags[trim($tag)] = $this->url->link( 'pavblog/blogs','tag='.trim($tag) );
				}
				
				$this->data['tags'] = $tags;
				if( $this->mparams->get('enable_recaptcha') ){  
					if ($this->config->get('config_ssl')) {
						$recaptcha_ssl = true;
					} else {
						$recaptcha_ssl = false;
					}
				//	require_once(DIR_SYSTEM . 'library/recaptchalib.php');
				//	$this->data['recaptcha'] = recaptcha_get_html($this->mparams->get('recaptcha_public_key'), null, $recaptcha_ssl);

				}else {
					$this->data['recaptcha'] = null;
				}
				$this->data['link'] =  $this->url->link( 'pavblog/blog','id='.$blog['blog_id'] );
				
				if (isset($this->request->get['page'])) {
					$page = $this->request->get['page'];
				} else { 
					$page = 1;
				}	
				$limit = $this->getParam( 'comment_limit' );
			
				$url = '';
				$pagination = new Pagination();
				$pagination->total = $blog['comment_count'];
				$pagination->page = $page;
				$pagination->limit =  $limit;
				$pagination->text = $this->language->get('text_pagination');
				$pagination->url = $this->url->link('pavblog/blog', 'id=' . $blog['blog_id'] . $url . '&page={page}');
				$data = array(
					'blog_id' => $blog['blog_id'],
					'start'              => ($page - 1) * $limit,
					'limit'              => $limit
				);
				$this->data['comments'] = $this->getModel('comment')->getList( $data );
				
				$this->data['pagination'] = $pagination->render();
								
				$this->getModel( 'blog' )->updateHits( $blog_id ); 
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/pavblog/blog.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/pavblog/blog.tpl';
				} else {
					$this->template = 'default/template/pavblog/blog.tpl';
				}
				
				$this->children = array(
					'common/column_left',
					'common/column_right',
					'common/content_top',
					'common/content_bottom',
					'common/footer',
					'common/header'
				);
							
				$this->response->setOutput($this->render());
			} else {
				$this->data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_error'),
					'href'      => $this->url->link('information/information', 'category_id=' . $category_id),
					'separator' => $this->language->get('text_separator')
				);
					
				$this->document->setTitle($this->language->get('text_error'));
				
				$this->data['heading_title'] = $this->language->get('text_error');

				$this->data['text_error'] = $this->language->get('text_error');

				$this->data['button_continue'] = $this->language->get('button_continue');
				
				$this->data['continue'] = $this->url->link('common/home');

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
				} else {
					$this->template = 'default/template/error/not_found.tpl';
				}
				
				$this->children = array(
					'common/column_left',
					'common/column_right',
					'common/content_top',
					'common/content_bottom',
					'common/footer',
					'common/header'
				);
						
				$this->response->setOutput($this->render());
			}
		}
		
		public function captcha() {
			$this->load->library('captcha');
		
			$captcha = new Captcha();
		
			$this->session->data['captcha'] = $captcha->getCode();
		
			$captcha->showImage();
		}	


		/**
		 * process adding comment
		 */
		public function comment(){
			$this->preload();
			$error = array();
			

			if( isset($this->request->post['comment']) ){
				$d = array('email'=>'','user'=>'','comment'=>'','blog_id'=>'');
			
				$data = $this->request->post['comment'];
				$data  = array_merge( $d,$data );
				if( $this->mparams->get('enable_recaptcha') ){ 
					if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
      					$error['captcha'] = '<div class="comment-warning">'.$this->language->get('error_captcha').'</div>';
    				} 
				}
				
				if( !preg_match( "/^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+$/", $data['email'])) {
					 $error['email'] = '<div class="comment-warning">'.$this->language->get('error_email').'</div>';
				}
				if( empty($data['comment']) ){
					$error['comment'] = '<div class="comment-warning">'.$this->language->get('error_comment').'</div>';
				}
				if( empty($data['user']) ){
					$error['user'] = '<div class="comment-warning">'.$this->language->get('error_user').'</div>';
				}
				

				if( empty($error) && $data['blog_id'] ){
					$this->getModel('comment')->saveComment( $data, $this->mparams->get('auto_publish_comment') );
					$output = array('hasError'=>false, 'message'=> '' );
					echo json_encode( $output );die();
				}
			}
			$output = array('hasError'=>true, 'message'=> implode(" \r\n ", $error ) );
			echo json_encode( $output );die();
		}
	}	
	?>