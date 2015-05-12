<?php 
/**
 * class ControllerpavblogBlog 
 */
	class ControllerpavblogBlogs extends Controller {
	
		private $mparams = '';
		
		public function preload(){
		
			$this->load->model('tool/image'); 			
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
			
	
			if( !defined("_PAVBLOG_MEDIA_") ){
				
				define("_PAVBLOG_MEDIA_",true);
			}
		}
		
		public function getParam( $key, $value='' ){
			return  $this->mparams->get( $key, $value );
		}
		
		/**
		 * get model object
		 */
		public function getModel( $model='blog' ){
			return $this->{"model_pavblog_{$model}"};
		}
		
		/**
		 * get rss feed by category id 
		 */
		public function rss(){
			
			$this->preload();
			if( isset($this->request->get['id']) ){
				$id = (int)$this->request->get['id'];
			} else {
				$id = 0;
			}
			
			$category_info = $this->getModel()->getInfo( $id );	
			
			$output = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<rss version="2.0">';
			$output .= '<channel>';

			$output .= '<title><![CDATA[' . $this->language->get('blogs_latest_header_title'). ' - ' . $this->config->get('config_name') . ']]></title>';
			$output .= '<description><![CDATA[' . $this->config->get('config_meta_description') . ']]></description>';
			$output .= '<link><![CDATA[' . HTTP_SERVER . ']]></link>';
			
			$page = 1;
			$limit = (int)$this->mparams->get('rss_limit_item')?(int)$this->mparams->get('rss_limit_item'):100;
			
			$data = array(
				'filter_category_id' => '',
				'sort'               => 'b.created',
				'order'              => 'ASC',
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

			$blogs = $this->getModel('blog')->getListBlogs(  $data );
			

			foreach( $blogs as $blog ){
				$link =  str_replace("&amp;","&",$this->url->link( 'pavblog/blog','id='.$blog['blog_id'] ));
				if( $blog['image'] ){
					$image = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_swidth'), $this->mparams->get('general_sheight') ,'w' );
					$description = '<a href="'.$link.'"><img class="rss_blog_image" src="'.$image.'"/></a>'.  html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8'); 
				}else {
					$description =  html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
				} 
			
				$output .= '<item>';
				$output .= '<title><![CDATA[' . $blog['title'] . ']]></title>';
				$output .= '<link><![CDATA[' .$link. ']]></link>';
				$output .= '<description><![CDATA[' . $description . ']]></description>';
				$output .= '<guid>' . $blog['blog_id'] . '</guid>';
				$output .= '<pubDate>' . date('D, j F Y H:i:s e', strtotime($blog['created'])) . '</pubDate>';
				$output .= '</item>';
			}
			$output .= '</channel>';
			$output .= '</rss>';
			$this->response->addHeader('Content-Type: application/rss+xml');
			$this->response->setOutput($output);
		
		}
		/**
		 * index action
	     *
		 */
		public function index() {  
			 
			$this->preload();
			 
			
			$this->data['breadcrumbs'] = array();
			
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home'),
				'separator' => false
			);
		 
			
			if (isset($this->request->get['filter'])) {
				$filter = $this->request->get['filter'];
			} else {
				$filter = '';
			}
					
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'b.sort_order';
			}

			if (isset($this->request->get['order'])) {
				$order = $this->request->get['order'];
			} else {
				$order = 'DESC';
			}
			
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else { 
				$page = 1;
			}	
								
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit =  (int)$this->mparams->get( 'cat_limit_leading_blog' ) +  (int)$this->mparams->get( 'cat_limit_secondary_blog' );
			}
		

			$this->load->model("pavblog/category");
			$users = $this->getModel('category')->getUsers();
			$this->data['config']	 = $this->mparams; 
			
			if( isset($this->request->get['tag']) ){
				$filter_tag = $this->request->get['tag'];
			}else {
				$filter_tag = '';
			}
			
			$data = array(
				'filter_category_id' => '',
				'filter_filter'      => $filter, 
				'filter_tag'  		 => $filter_tag,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
			
			if( $filter || $filter_tag ){
				$this->data['heading_title'] = $this->language->get('filter_blog_header_title');
			} else {
				$this->data['heading_title'] = $this->language->get('blogs_latest_header_title');
				$data['sort'] = 'b.created';
				$order = 'DESC';
			}
			
		
			$blogs = $this->getModel( 'blog' )->getListBlogs(  $data );
			
			if ($blogs) {
				
				
				$total = $this->getModel( 'blog' )->getTotal( $data );
				
				$url = '';
				
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}	

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}	
				
				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}
				
				if (isset($this->request->get['tag'])) {
					$url .= '&tag=' . $this->request->get['tag'];
					$this->data['heading_title'] = sprintf($this->data['heading_title'] , "tag: ".$this->request->get['tag']);
				}
				$this->document->setTitle( $this->data['heading_title'] );
				
				
				$limit_leading_blogs = (int)$this->mparams->get( 'cat_limit_leading_blog' );
				$type = array('l'=>'thumb_large','s'=>'thumb_small');
				$limageType = isset($type[$this->mparams->get('cat_leading_image_type')])?$type[$this->mparams->get('cat_leading_image_type')]:'thumb_xsmall';
				$simageType = isset($type[$this->mparams->get('cat_secondary_image_type')])?$type[$this->mparams->get('cat_secondary_image_type')]:'thumb_xsmall';
				
	
				foreach( $blogs as $key => $blog ){
					if( $blogs[$key]['image'] ){	
						$blogs[$key]['thumb_large'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_lwidth'), $this->mparams->get('general_lheight'),'w');
						$blogs[$key]['thumb_small'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_swidth'), $this->mparams->get('general_sheight') ,'w');
						$blogs[$key]['thumb_xsmall'] = $this->model_tool_image->resize($blog['image'],$this->mparams->get('general_xwidth'), $this->mparams->get('general_xheight'),'w' );
					}else {
						$blogs[$key]['thumb_large'] = '';
						$blogs[$key]['thumb_small'] = '';
						$blogs[$key]['thumb_xsmall'] = '';
					}
					if( $key < $limit_leading_blogs ){
						$blogs[$key]['thumb'] = $blogs[$key][$limageType];
					}else {
						$blogs[$key]['thumb'] = $blogs[$key][$simageType];
					}					
					
					$blogs[$key]['description'] = html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
					$blogs[$key]['author'] = isset($users[$blog['user_id']])?$users[$blog['user_id']]:$this->language->get('text_none_author');
					$blogs[$key]['category_link'] =  $this->url->link( 'pavblog/category', "id=".$blog['category_id'] );
					$blogs[$key]['comment_count'] =  $this->getModel('comment')->countComment( $blog['blog_id'] );
					$blogs[$key]['link'] =  $this->url->link( 'pavblog/blog','id='.$blog['blog_id'] );
				}
				
				$leading_blogs 		 = array_slice( $blogs,0, $limit_leading_blogs );
				$secondary_blogs 	 = array_splice( $blogs, $limit_leading_blogs, count($blogs) );
		
				
			 	$this->data['config'] = $this->mparams;
				$this->data['leading_blogs'] = $leading_blogs;
				$this->data['secondary_blogs'] = $secondary_blogs;
				$this->data['latest_rss'] =  $this->url->link( 'pavblog/blogs/rss' );
				
				$pagination = new Pagination();
				$pagination->total = $total;
				$pagination->page = $page;
				$pagination->limit =  $limit;
				$pagination->text = $this->language->get('text_pagination');
				$pagination->url = $this->url->link('pavblog/blogs',  $url . '&page={page}');
				
				$this->data['pagination'] = $pagination->render();
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/pavblog/blogs.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/pavblog/blogs.tpl';
				} else {
					$this->template = 'default/template/pavblog/blogs.tpl';
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
				$category_id = isset($this->request->get["id"])?$this->request->get["id"]:0;
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
		
	}	
	?>