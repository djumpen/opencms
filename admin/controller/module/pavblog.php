<?php
/******************************************************
 * @package Pav blog module for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

/**
 * class ControllerModulePavblog
 */
class ControllerModulePavblog extends Controller {

	/**
	 *
	 */
	private $error = array();

	private $module_folder = 'modules';
	private $moduleName = 'pavblog';
	private $list_modules = array();
	/**
	 * set template layout
	 */
	public function setTemplate( $tpl ){


		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['token'] =  $this->session->data['token'];
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}

		$this->data['manage_category_link'] = $this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['add_category_link'] = $this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['manage_blog_link'] = $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['add_blog_link'] = $this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['manage_comment_link'] = $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['modules_setting_link'] = $this->url->link('module/pavblog/modules', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['frontend_modules_link'] = $this->url->link('module/pavblog/frontmodules', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['dashboard_link'] = $this->url->link('module/pavblog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['information'] = $this->url->link('module/pavblog/information', 'token=' . $this->session->data['token'], 'SSL');


		$this->data['token'] = $this->session->data['token'];

		$this->document->addStyle('view/stylesheet/pavblog.css');
		// $this->data['toolbar'] = $this->
		$this->template =  'module/pavblog/'.$tpl.".tpl";
		$this->children = array(
			'common/header',
			'common/footer'
		);

		return $this->response->setOutput($this->render());
	}

	/**
	 * set breadcrumb
	 */
	public function setBreadcrumb(){


		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavblog', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	/**
	 * Dardboard Page
	 */
	public function index(){
		$this->preProcess();
		$this->load->model('pavblog/comment');
		$this->applyLangVars();
		$this->setBreadcrumb();
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}

		$this->data['mostread'] = $this->model_pavblog_blog->getMostRead();
		$this->data['newest'] = (array)$this->model_pavblog_blog->geNewest();
		$this->data['comments'] = (array)$this->model_pavblog_comment->getNewest();


		$this->data['heading_title'] = $this->language->get('panel_page_heading_title');
		$this->data['module_setting'] = $this->getModuleSetting();
		$this->document->setTitle( $this->data['heading_title'] );
		return $this->setTemplate( 'panel' );
	}

	/**
	 * Category Page
	 */
	public function category(){
		$this->language->load('module/pavblog');
		$this->applyLangVars();
		$this->setBreadcrumb();
		$this->document->setTitle( strip_tags( $this->language->get('heading_title') ));
		$this->document->addStyle('view/stylesheet/pavblog.css');
 		$this->document->addScript('view/javascript/pavblog/jquery.nestable.js');
		
		$this->load->model('pavblog/menu');
		// check tables created or not
		$this->model_pavblog_menu->install();
		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST')  && !empty($this->request->post) ) {

			if( (int)$this->request->post['pavblog_category']['category_id'] <= 0 ){
				$this->request->post['pavblog_category']['position'] = '99';
			}
			if(  $this->validateCategory() ) {
				$id = $this->model_pavblog_menu->editData(  $this->request->post );
				$this->session->data['success'] = $this->language->get('text_success');
				if( $this->request->post['save_mode']=='save-edit'){
					$this->redirect($this->url->link('module/pavblog/category', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL'));
				}	else {
					$this->redirect($this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL'));
				}


				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}


		}

		





 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}

		$this->data['action'] = $this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['actionGetTree'] = $this->url->link('module/pavblog/gettree', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['actionDel'] = $this->url->link('module/pavblog/delete', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['actionGetInfo'] = $this->url->link('module/pavblog/info', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['updateTree'] = $this->url->link('module/pavblog/update', 'root=1&token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('module/pavblog', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();




		$this->data['tree'] = $this->model_pavblog_menu->getTree(  );

		$this->info();


		return $this->setTemplate( 'category' );
	}

 	/**
 	 * Delete Category Menu By Id
 	 */
	public function delete(){
		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if( isset($this->request->get['id']) ){
			$this->load->model('pavblog/menu');
			$this->model_pavblog_menu->delete( (int)$this->request->get['id'] );

		}
		$this->redirect($this->url->link('module/pavblog', 'token=' . $this->session->data['token'], 'SSL'));
	}

	/**
	 * Update Category Tree Menu
	 */
	public function update(){
		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		$data =  ( ($this->request->post['list']) );
		if( !empty($data) ){
			$root = $this->request->get['root'];
			$this->load->model('pavblog/menu');
			$this->model_pavblog_menu->massUpdate( $data, $root  );
			die("Update done!!!");
		}
		die("Could not update any thing");
	}

	/**
	 * Get Category Menu infomration by Id in request
	 *
	 */
	public function info(){
		$id=0;
		if( isset($this->request->post) && isset($this->request->post['id']) ){
			$id = (int)$this->request->post['id'] ;
		}else if( isset($this->request->get["id"]) ){
			$id = (int)$this->request->get['id'];
		}
		$default = array(
			'category_id'=>'',
			'title' => '',
			'parent_id'=> '',
			'tags' => '',
			'image' => '',
			'is_group'=>'',
			'width'=>'12',
			'menu_class'=>'',
			'submenu_colum_width'=>'',
			'is_group'=>'',
			'submenu_width'=>'12',
			'column_width'=>'200',
			'submenu_column_width'=>'',
			'colums'=>'1',
			'type' => '',
			'item' => '',
			'is_content'=>'',
			'show_title'=>'1',
			'type_submenu'=>'',
			'level_depth'=>'',
			'status'    => '',
			'position'  => '',
			'show_sub' => '',
			'url' => '',
			'targer' => '',
			'level'=> '',
			'content_text'=>'',
			'submenu_content'=>'',
			'blog-information'=>'',
			'blog-product'=>'',
			'blog-category'=>'',
			'published' => 1,
			'blog-manufacturer'=>'',
			'thumb' => '',
			'meta_keyword'=>'',
			'meta_description'=>'',
			'meta_title'=>'',
			'keyword' => ''
		);

		$this->language->load('module/pavblog');
		$this->applyLangVars();
		$this->load->model('pavblog/menu');

		$this->load->model('localisation/language');
		$this->load->model('tool/image');
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 16, 16);

		$this->data['entry_image'] = 'Image:';
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['yesno'] = array( '0' => $this->language->get('text_no'),'1'=> $this->language->get('text_yes') );
		$this->data['token'] = $this->session->data['token'];
		$this->data['languages'] = $this->model_localisation_language->getLanguages();


		$menu = $this->model_pavblog_menu->getInfo( $id );
		$menu = array_merge( $default, $menu );



		$this->data['menu'] = $menu;
		$this->data['menus'] = $this->model_pavblog_menu->getDropdown(null, $menu['parent_id'] );
		$this->data['thumb'] = $this->model_tool_image->resize($menu['image'], 150, 150);
		$this->data['menu_description'] = array();
		$descriptions  = $this->model_pavblog_menu->getMenuDescription( $id );
		$this->data['menu_description'] = array();



		foreach( $descriptions as $d ){
			$this->data['menu_description'][$d['language_id']] = $d;
		}


		foreach(  $this->data['languages'] as $language ){
			if( empty($this->data['menu_description'][$language['language_id']]) ){
				$this->data['menu_description'][$language['language_id']]['title'] = '';
				$this->data['menu_description'][$language['language_id']]['description'] = '';
			}
		}



		if( isset($this->request->post['blog']) ){
			$menu = array_merge($menu, $this->request->post['blog'] );
		}
		$this->data['menu'] = $menu;


		$this->data['submenutypes'] = array('menu'=>'Menu', 'html'=>'HTML');
		$this->data['text_edit_menu'] = $this->language->get('text_edit_menu');
		$this->data['text_create_new'] = $this->language->get('text_create_new');
		$this->template = 'module/pavblog/category_form.tpl';
		$this->response->setOutput($this->render());

	}

 	/**
 	 * check validation for category
  	 */
	protected function validateCategory() {

		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['pavblog_category_description'])) {

			$language_id = $this->config->get('config_language_id');

			if( empty($this->request->post['pavblog_category_description'][$language_id ]['title']) ){
				$this->error['warning'][]=$this->language->get('error_missing_title');
			}

		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * check validation for blog
	 */
	protected function validateBlog() {

		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['pavblog_blog_description'])) {

			$language_id = $this->config->get('config_language_id');

			if( empty($this->request->post['pavblog_blog_description'][$language_id ]['title']) ){
				$this->error['warning'][]=$this->language->get('error_missing_title');
			}
			if( empty($this->request->post['pavblog_blog_description'][$language_id ]['description']) ){
				$this->error['warning'][]=$this->language->get('error_missing_description');
			}
			if( empty($this->request->post['pavblog_blog_description'][$language_id ]['content']) ){
				$this->error['warning'][]=$this->language->get('error_missing_content');
			}

		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * pre process for loading needed models and check installation of this module.
	 */
	protected function preProcess(){
		$this->load->model('pavblog/blog');
		$this->language->load('module/pavblog');

		$this->load->model('pavblog/install');
		$this->getModel( 'install' )->checkInstall();
	}

	/**
	 * Blog Management Page
	 */
	public function blog(){

		$this->preProcess();
		$this->load->model('pavblog/menu');

		$this->load->model('tool/image');
		$this->load->model('user/user');
		$this->applyLangVars();
		// save to database

		if (isset($this->request->post) && isset($this->request->post['pavblog_blog']) ) {
			if( $this->validateBlog() ) {
				$id = $this->model_pavblog_blog->saveData( $this->request->post );
				$action = $this->request->post['action_mode'];
				if( $action == 'save-edit' ){
					$this->redirect($this->url->link('module/pavblog/blog', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL'));
				}elseif( $action == 'save-new' ){
					$this->redirect($this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL'));
				}else {
					$this->redirect($this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}
		}
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');

		$this->document->setTitle( $this->language->get('blog_page_heading_title') );
		$blog = array(
			'blog_id'=>0,
			'featured' => 0,
			'category_id'=>0,
			'position'=>'99',
			'status'=>'1',
			'image'=>'',
			'thumb' => '',
			'video_code'=>'',
			'user_id'=>'',
			'tags' => '',
			'hits'=>'0',
			'created'=>date("Y-m-d"),
			'image'=>'',
			'meta_keyword'=>'',
			'meta_description'=>'',
			'meta_title'=>'',
			'keyword' => ''
		);

		$blog['thumb'] = $this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 180, 180);
		$this->load->model('localisation/language');
		$data = array();
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		if( isset($this->request->get['id']) ){
			$data = $this->model_pavblog_blog->getBlog( (int)$this->request->get['id'] );
			$blog = array_merge( $blog, $data['blog'] );
			if( $blog['image'] ){
				$blog['thumb'] = $this->model_tool_image->resize($blog['image'], 180, 180);
			}
		}
		$blog_descriptions = array();

		$this->data['users'] = $this->model_user_user->getUsers();


		foreach( $this->data['languages'] as $k => $language ){
			if( isset($data['blog_description']) && isset($data['blog_description'][$language['language_id']]) ){
				$blog_descriptions[$language['language_id']] = $data['blog_description'][$language['language_id']];
			}else {
				$blog_descriptions[$language['language_id']] = array('title'=>'','description'=>'','content'=>'');
			}
		}

		$this->data['action'] = $this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action_delete'] = $this->url->link('module/pavblog/deleteblog', 'id='.$blog['blog_id'].'&token=' . $this->session->data['token'], 'SSL');
		$this->data['menus'] = $this->model_pavblog_menu->getDropdown(null, $blog['category_id'], 'pavblog_blog[category_id]' );
		$this->data['yesno'] = array( 0 => $this->language->get('no'), 1=>$this->language->get('yes') );
		$this->data['blog'] = $blog;
		$this->data['pavblog_blog_descriptions'] = $blog_descriptions;
		$this->setBreadcrumb();
		$this->setTemplate("blog");
	}

	/**
	 * Listing Blogs Management Page.
	 */
	public function blogs(){
		$this->load->model('pavblog/menu');
		$this->preProcess();
		$filter = array('title'=>'','category_id'=> '');
		if( isset($this->request->post['filter']) ){
			$this->session->data['blog_filter'] = $this->request->post['filter'];
		}
		if( isset($this->request->get['reset']) ){
			$this->session->data['blog_filter'] = null;
		}
		if( isset($this->session->data['blog_filter'])  ){
			 $filter = array_merge($filter,$this->session->data['blog_filter']);
		}

		if( isset($this->request->post['selected']) ){
			$ids = $this->request->post['selected'];
			$this->getModel('blog')->saveAction( $ids, $this->request->post['do-action'] );
		}
		if( isset($this->request->post['do-action'])  && $this->request->post['do-action'] == 'position' ){
			$this->getModel('blog')->savePosition( $this->request->post['position'] );
		}
		$this->data['menus'] = $this->model_pavblog_menu->getDropdown(null, $filter['category_id'], 'filter[category_id]' );

		$this->data['filter'] = $filter;
		$this->data['create_blog_link'] = $this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['edit_link'] = $this->url->link('module/pavblog/blog', 'id=%s&token=' . $this->session->data['token'], 'SSL');
		$this->document->setTitle( $this->language->get('blogs_page_heading_title') );
		$this->data['heading_title'] =  $this->language->get('blogs_page_heading_title');
		$this->data['action'] = $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action_reset'] = $this->url->link('module/pavblog/blogs', 'reset=true&token=' . $this->session->data['token'], 'SSL');


		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}



		$data = array(
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		$this->data['blogs'] = $this->model_pavblog_blog->getList( $data, $filter );
		$total =  $this->model_pavblog_blog->getTotal( $data, $filter );
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();
		$this->setBreadcrumb();
		$this->setTemplate("blogs");
	}

	public function deleteblog(){
		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if( isset($this->request->get['id']) && $id=$this->request->get['id'] ){
			$this->loadModel( 'blog' );
			$this->model_pavblog_blog->delete( $id );
		}
		$this->redirect( $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL') );
	}

	public function getModel( $model ){
		return $this->{"model_pavblog_".$model};
	}

	public function loadModel( $model ){
		$this->load->model( 'pavblog/'.$model );
	}

	/**
	 *
	 */
	public function comments(){
		$this->preProcess();

		$this->setBreadcrumb();
		$this->loadModel( 'comment' );
		if( isset($this->request->post['selected']) ){
			switch(  $this->request->post['do-action'] ){
				case 'delete':
					if( isset($this->request->post['selected']) ){
						foreach( $this->request->post['selected'] as $id ){
							$this->getModel('comment')->delete( (int)$id );
						}
					}
					break;
				case 'published':
					if( isset($this->request->post['selected']) ){
						foreach( $this->request->post['selected'] as $id ){
							$this->getModel('comment')->savePublished( (int)$id, 1 );
						}
					}
					break;
				case 'unpublished':
					if( isset($this->request->post['selected']) ){
						foreach( $this->request->post['selected'] as $id ){
							$this->getModel('comment')->savePublished( (int)$id, 0 );
						}
					}
					break;
			}
		}
		$this->document->setTitle( $this->language->get('comments_page_heading_title') );
		$this->data['heading_title'] =  $this->language->get('comments_page_heading_title');
		$this->data['comments'] =  $this->getModel('comment')->getList();
		$this->data['action'] = $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL');

		$this->setTemplate("comments");

	}
	/**
	 * Comment Page
	 */
	public function comment(){
		if( isset($this->request->get['id']) && $id=$this->request->get['id'] ){
			$this->load->model('pavblog/comment');
			$id = $this->request->get['id'];
			$this->preProcess();

			if( isset($this->request->post['action_mode']) && isset($this->request->post['pavblog_comment']) ){
				$this->getModel('comment')->saveComment( $this->request->post['pavblog_comment'] );
				if( $this->request->post['action_mode']=='save-edit' ){
					$this->redirect( $this->url->link('module/pavblog/comment', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL' ) );
				}else {
					$this->redirect( $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL' ) );
				}
			}
			$this->setBreadcrumb();
			$this->document->setTitle( $this->language->get('blogs_page_heading_title') );
			$this->data['heading_title'] =  $this->language->get('blogs_page_heading_title');
			$this->data['action'] = $this->url->link('module/pavblog/comment', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL');
			$this->data['action_delete'] = $this->url->link('module/pavblog/deletecomment', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL');

			$this->data['yesno'] = array( 0 => $this->language->get('no'), 1=>$this->language->get('yes') );
			$comment = array(
				'blog_id' => '',
				'comment' => '',
				'status' => '0',
				'created' => '',
				'user'    => '',
				'email'   => '',
			);
			$tmp = $this->model_pavblog_comment->getComment( $id );
			if( $tmp ){
				$comment = array_merge( $comment, $tmp );
			}




			$this->data['comment'] = $comment ;
			$this->setTemplate("comment");
		}else {
			$this->redirect( $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL') );
		}
	}

	/**
	 * Delete Comments
	 */
	public function deletecomment(){
		if (!$this->user->hasPermission('modify', 'module/pavblog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		$this->loadModel('comment');
		if( isset($this->request->get['id']) ){
			$this->getModel('comment')->delete( (int)$this->request->get['id'] );
		}
		if( isset($this->request->post['selected']) ){
			foreach( $this->request->post['selected'] as $id ){
				$this->getModel('comment')->delete( (int)$id );
			}
		}
		$this->redirect( $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL') );
	}

	private function getModuleSetting(){
		$default = array(
			'children_columns' => '3',
			'general_cwidth' => '250',
			'general_cheight' => '250',
			'general_lwidth'=> '620',
			'general_lheight'=> '300',
			'general_sheight'=> '250',
			'general_swidth'=> '250',
			'general_xwidth' => '80',
			'general_xheight' => '80',
			'cat_show_hits' => '1',
			'cat_limit_leading_blog'=> '1',
			'cat_limit_secondary_blog'=> '5',
			'cat_leading_image_type'=> 'l',
			'cat_secondary_image_type'=> 's',
			'cat_show_title'=> '1',
			'cat_show_image'=> '1',
			'cat_show_author'=> '1',
			'cat_show_category'=> '1',
			'cat_show_created'=> '1',
			'cat_show_readmore' => 1,
			'cat_show_description' => '1',
			'cat_show_comment_counter'=> '1',

			'blog_image_type'=> 'l',
			'blog_show_title'=> '1',
			'blog_show_image'=> '1',
			'blog_show_author'=> '1',
			'blog_show_category'=> '1',
			'blog_show_created'=> '1',
			'blog_show_comment_counter'=> '1',
			'blog_show_comment_form'=>'1',
			'blog_show_hits' => 1,
			'cat_columns_leading_blogs'=> 1,
			'cat_columns_secondary_blogs' => 2,
			'comment_engine' => 'local',
			'diquis_account' => 'pavothemes',
			'facebook_appid' => '100858303516',
			'facebook_width'=> '600',
			'comment_limit'=> '10',
			'auto_publish_comment'=>0,
			'enable_recaptcha' => 1,
			'recaptcha_public_key'=>'6LcoLd4SAAAAADoaLy7OEmzwjrf4w7bf-SnE_Hvj',
			'recaptcha_private_key'=>'6LcoLd4SAAAAAE18DL_BUDi0vmL_aM0vkLPaE9Ob',
			'rss_limit_item' => 12,
			'keyword_listing_blogs_page'=>'blogs'

		);
		$general_setting = $this->config->get('pavblog');
		$general_setting = !empty($general_setting)?$general_setting:array();

		if( $general_setting ){
			$general_setting =  array_merge( $default,$general_setting);
		}else{
			$general_setting = $default;
		}
		return $general_setting;
	}

	/**
	 * Modules Setting Page
	 */
	public function modules(){
		$this->preProcess();
		$this->load->model('setting/setting');
		if( isset($this->request->post['pavblog']) ){
			$data = array();

			$data['pavblog'] = $this->request->post['pavblog'];
			$this->model_setting_setting->editSetting('pavblog', $data );

			$this->redirect( $this->url->link('module/pavblog/modules', 'token=' . $this->session->data['token'], 'SSL') );

		}

		$general_setting = $this->getModuleSetting();

		$this->data['general_setting'] = $general_setting;
		$this->setBreadcrumb();
		$this->load->model('localisation/language');
		$this->document->setTitle( $this->language->get('modules_page_heading_title') );
		$this->data['heading_title'] =  $this->language->get('modules_page_heading_title');

		$this->data['comment_engine'] = array('facebook'=>'Facebook','diquis' => 'Diquis', 'local'=>'Local' );
		$this->data['yesno'] = array( '0' => $this->language->get('text_no'),'1'=> $this->language->get('text_yes') );
		$this->data['image_types'] = array( 'l' => $this->language->get('text_large_image'),'s'=> $this->language->get('text_small_image') );
		$this->data['token'] = $this->session->data['token'];
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['action'] = $this->url->link('module/pavblog/modules', 'token=' . $this->session->data['token'], 'SSL');


		$this->data['positions'] = array( 'mainmenu',
										  'slideshow',
										  'showcase',
										  'mass_bottom',
										  'promotion',
										  'content_top',
										  'column_left',
										  'column_right',
										  'content_bottom',
										  'footer_top',
										  'footer_center',
										  'footer_bottom'
		);

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
			$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->load->model('design/layout');


		$this->data['layouts'] = array();
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );

		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

		$this->setTemplate("modules");

	}

	protected function moduleValidate($module = "") {
		if ($module == "pavbloglatest_module" && isset($this->request->post[$module])) {
			foreach ($this->request->post[$module] as $key => $value) {
				if (!$value['width'] || !$value['height']) {
					$this->error['dimension'][$key] = $this->language->get('error_dimension');
				}

				if (!$value['limit'] || !$value['cols']   ) {
					$this->error['dimension'][$key] = $this->language->get('error_carousel');
				}
			}

			if (!$this->error) {
				return true;
			} else {
				return false;
			}
		}
		return true;

	}
	public function frontmodules(){
		$this->preProcess();
		$this->load->model('setting/setting');
		if( isset($this->request->post['pavblog_frontmodules']) ){
			$data = array();

			$data['pavblog_frontmodules'] = $this->request->post['pavblog_frontmodules'];
			/*Updated config for modules*/
			$post = $this->request->post;
			$data = $this->request->post['pavblog_frontmodules'];
			$this->request->post= array();
			$this->request->post['pavblog_frontmodules'] = $data;
			$this->model_setting_setting->editSetting('pavblog_frontmodules', $this->request->post);
			$list_modules = isset($data['modules'])?$data['modules']:array();
			foreach($list_modules as $module){
				if(isset($post[$module.'_module'])){
					$this->request->post= array();
					$this->request->post[$module.'_module'] = $post[$module.'_module'];
					if($this->moduleValidate($module.'_module'))
					  $this->model_setting_setting->editSetting($module, $this->request->post);
				}
			}
			$this->redirect( $this->url->link('module/pavblog/frontmodules', 'token=' . $this->session->data['token'], 'SSL') );

		}

		$general_setting = $this->getModuleSetting();

		$this->data['general_setting'] = $general_setting;
		$this->setBreadcrumb();
		$this->load->model('localisation/language');
		$this->document->setTitle( $this->language->get('modules_page_heading_title') );
		$this->data['heading_title'] =  $this->language->get('modules_page_heading_title');

		$this->data['comment_engine'] = array('facebook'=>'Facebook','diquis' => 'Diquis', 'local'=>'Local' );
		$this->data['yesno'] = array( '0' => $this->language->get('text_no'),'1'=> $this->language->get('text_yes') );
		$this->data['image_types'] = array( 'l' => $this->language->get('text_large_image'),'s'=> $this->language->get('text_small_image') );
		$this->data['token'] = $this->session->data['token'];
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['action'] = $this->url->link('module/pavblog/frontmodules', 'token=' . $this->session->data['token'], 'SSL');


		$this->data['positions'] = array( 'mainmenu',
										  'slideshow',
										  'showcase',
										  'promotion',
										  'mass_bottom',
										  'content_top',
										  'column_left',
										  'column_right',
										  'content_bottom',
										  'footer_top',
										  'footer_center',
										  'footer_bottom'
		);

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
			$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->load->model('design/layout');
		$this->tabModules();

		$tabs = array(
			'latest' 	 => $this->language->get('text_latest'),
			'featured'   => $this->language->get('text_featured'),

			'mostviewed' => $this->language->get('text_mostviewed')
		);

		$this->data['tabs'] = $tabs;
		$this->data['options'] =  $this->model_pavblog_menu->genOption( 1 ,1, '' );

		$this->data['layouts'] = array();
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );

		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

		$this->setTemplate("frontmodules");

	}
	/**
	 * Information Page
	 */
	public function information(){
		$this->preProcess();
		$this->setBreadcrumb();

		$this->document->setTitle( $this->language->get('modules_page_heading_title') );
		$this->data['heading_title'] =  $this->language->get('modules_page_heading_title');
		$this->setTemplate("information");
	}
	public function tabModules() {
		$modules_path = DIR_APPLICATION.'view/template/module/'.$this->moduleName.'/'.$this->module_folder.'/';

		$this->list_modules = array();
		if( is_dir($modules_path) ) {
			$files = glob($modules_path.'*.tpl');
			foreach( $files as $dir ){
				$filename = str_replace(".tpl","",basename( $dir ) );
				$filename = trim($filename);
				$this->list_modules[$filename] = str_replace("","",basename( $dir ) );
			}
		}
		$this->data['layout_modules'] = $this->getModules( $this->list_modules);
	}
	public function getModules( $list_files = array() ){
		if(empty($list_files)) return false;
		$this->load->model('pavblog/blog');
		$module_data = array();
		$this->load->model('pavblog/menu');
      if(!empty($list_files)){
          foreach($list_files as $key => $file){
              $modules = $this->config->get($key.'_module' );
              $tmp_modules = array();
              if(!empty($modules)){
                  $sort_order = array();
                  foreach ($modules as $index => $module) {
                      switch ($key) {
                          case 'pavblogcategory':
                              $module['category_id'] = isset($module['category_id'])?$module['category_id']:0;
                              $module['sort_order'] = isset($module['sort_order'])?$module['sort_order']:0;
                              $module['menus'] = $this->model_pavblog_menu->getDropdown(null, $module['category_id'], $key.'_module['.($index).'][category_id]' );
                              break;

                          default:

                              break;
                      }

                      $sort_order[$index] = isset($module['sort_order'])?$module['sort_order']:0;
                      $tmp_modules[] = $module;
                  }
                  array_multisort($sort_order, SORT_ASC, $tmp_modules);
              }else{
                  unset($list_files[$key]);
              }
              $module_data[$key] = $tmp_modules;
          }
      }
      $module_data = array_merge($list_files, $module_data);
      $this->language->load('module/'.$this->moduleName);
      $this->applyLangVars();
	  return $module_data;
	}
}
?>
