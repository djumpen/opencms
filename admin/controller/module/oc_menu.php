<?php 
class ControllerModuleOcmenu extends Controller { 
	private $error	   = array();
	private $menu_tmp  = array();
	
	public function index() {
		$this->load->model('module/oc_menu');
		
		$this->document->addScript(SCRIPT_FOLDER . 'oc_menu.js');
		$this->document->addScript(SCRIPT_FOLDER . 'pnotify.custom.min.js');
		$this->document->addScript(SCRIPT_FOLDER . 'ckeditor/ckeditor.js');
		$this->document->addScript(SCRIPT_FOLDER . 'file-uploader/Uploader.js');
		$this->document->addScript(SCRIPT_FOLDER . 'file-uploader/UploaderWithIframe.js');
		$this->document->addStyle(STYLE_FOLDER . 'pnotify.custom.min.css');
		$this->document->addStyle(SCRIPT_FOLDER . 'jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css');
		$this->document->addStyle(STYLE_FOLDER . 'oc_menu.css');
		
		$this->language->load('module/oc_menu');
		$this->applyLangVars();
		
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

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
			'href'      => $this->url->link('module/oc_menu', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['errors'] = array();
		
		
		
		$this->data['modules'] = $this->config->get('oc_menu_module');
		if(!$this->data['modules']) {
			$this->data['modules'] = array();
		}
		
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->data['action'] = $this->url->link('module/oc_menu/save_list', 'token=' . $this->session->data['token'], 'SSL');
		
		
		
		$this->template = 'module/oc_menu.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());	
	}
	
	public function save_list() {
		$this->load->model('setting/setting');
		if(isset($this->request->post['oc_menu_module'])) {
			$this->model_setting_setting->editSetting('oc_menu', $this->request->post);
			exit(json_encode(array('status'=> 'ok')));
		}
		$this->model_setting_setting->editSetting('oc_menu_module', array());
		exit(json_encode(array('status'=> 'ok')));
	}
	
	public function deleteGroup() {
		// Here must remove all content of the selected menu
		if(isset($this->request->post['group_id'])) {
			$this->load->model('module/oc_menu');
			$this->model_module_oc_menu->deleteMenuGroup($this->request->post['group_id']);
		}
	}
	
	public function getGroupPage() {
		if(isset($this->request->post['group_id'])) {
			$group_id = (int)$this->request->post['group_id'];
			$this->load->model('module/oc_menu');
			$this->data['group_id'] = $group_id;
			
			$this->data['tree'] = $this->getTree($group_id);
			
			
			$this->template = 'module/oc_menu_tree.tpl';
			$content = $this->render();
			exit(json_encode(array('status'=> 'ok', 'content' => $content, 'errors' => array())));
		} else {
			exit(json_encode(array('status'=> 'incorrect request', 'errors' => array('Current menu not exists'))));
		}
	}
	
	private function getTree($group_id, $parent_id = 0, $level = 1) {
		$branch = array();
		$group = $this->model_module_oc_menu->getGroup($group_id, $parent_id);
		foreach ($group as $node) {
			$branch[] = array(
				'level' 	  => $level,
				'type_icon'   => $node['type_icon'],
				'type_id'	  => $node['type_id'],
				'type' 		  => $node['type_name'],
				'description' => $node['description'],
				'name'		  => $node['name'],
				'menu_id'	  => $node['menu_id'],
				'sort_order'  => $node['sort_order'],
				'childrens'   => $this->getTree($group_id, $node['menu_id'], $level+1),
			);
		}
		
		return $branch;
	}
	
	public function getFormPage() {
		$this->load->model('module/oc_menu');
		$this->load->model('localisation/language');
		
		$this->language->load('module/oc_menu');
		$this->applyLangVars();
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->data['types'] = $this->model_module_oc_menu->getTypes();
		
		
		$this->template = 'module/oc_menu_form.tpl';
		exit($this->render());
	}
	
	public function getNodeInfo() {
		if(isset($this->request->post['node_id'])) {
			$this->load->model('module/oc_menu');
			$node = $this->model_module_oc_menu->getNodeInfo((int)$this->request->post['node_id']);
			exit(json_encode($node));
		} else {
			exit(json_encode(array()));
		}
	}
	
	public function autocomplete() {

		if(!empty($this->request->post['type']) && isset($this->request->post['name'])) {
			$this->load->model('module/oc_menu');
			$json = array();
			switch($this->request->post['type']) {
				case 'category':
					$json = $this->model_module_oc_menu->getACCategories($this->request->post['name']);
					
					break;
				case 'information':
					$json = $this->model_module_oc_menu->getACInformations($this->request->post['name']);
					
					break;
				case 'blog_category':
					$json = $this->model_module_oc_menu->getACBlogs($this->request->post['name']);
					
					break;
				case 'category_list':
					$json = $this->model_module_oc_menu->getACCategories($this->request->post['name']);
					
					break;
				case 'gallery':
					$json = $this->model_module_oc_menu->getACGalleries($this->request->post['name']);
					
					break;
				case 'products_list':
					$json = $this->model_module_oc_menu->getACProducts($this->request->post['name']);
					
					break;
				default:
					$json = array();
					break;
			}
			
			exit(json_encode($json));
		}
	}
	
	public function getMenuTypes() {
		$this->load->model('module/oc_menu');
		exit(json_encode($this->model_module_oc_menu->getMenuTypes()));
	}
	
	public function getTypePropertyId() {
		if(isset($this->request->post['prop']) && isset($this->request->post['type'])) {
			$this->load->model('module/oc_menu');
			exit(json_encode(array('id' => $this->model_module_oc_menu->getTypePropertyId($this->request->post['prop'], $this->request->post['type']))));
		}
	}
	
	public function getValueName() {
		if(isset($this->request->post['value']) && isset($this->request->post['type'])) {
			$this->load->model('module/oc_menu');
			exit(json_encode(array('name' => $this->model_module_oc_menu->getValueName($this->request->post['value'], $this->request->post['type']))));
		}
	}
	
	public function saveMenuList() {
		if(isset($this->request->post['branch'])) {
			$this->load->model('module/oc_menu');
			$menu = $this->request->post['branch'];
			if(!empty($menu[0])) {
				foreach ($menu[0] as $element) {
					if(!empty($element)) {
						$this->processTempElements($element, $menu[0]);
					}
				}
				array_shift($menu);
			}
			if(!empty($menu)) {
				$this->processElements($menu);
			}
		} else {
			die('Incorrect request!!!');
		}
	}
	
	private function processTempElements($element, $elements) {
		if(!empty($element['parent_tmp_id'])) {
			$parent_element = array();
			$parent_element_id = 0;
			foreach ($this->menu_tmp as $m_tmp) {
				if($m_tmp['node_tmp_id'] == $element['parent_tmp_id']) {
					$parent_element_id = $m_tmp['node_id'];
				}
			}
			if(!$parent_element_id) {
				foreach ($elements as $tmp_el) {
					if(!empty($tmp_el['node_tmp_id']) && $tmp_el['node_tmp_id'] == $element['parent_tmp_id']) {
						$parent_element = $tmp_el;
					}
				}
				if(!empty($parent_element)) {
					$parent_element_id = $this->processTempElements($parent_element, $elements);
				}
			}
		} elseif(!empty($element['parent_id'])) {
			$parent_element_id = $element['parent_id'];
		} else {
			$parent_element_id = 0;
		}
		$element_id = 0;
		foreach ($this->menu_tmp as $exists_element) {
			if($exists_element['node_tmp_id'] == $element['node_tmp_id']) {
				$element_id = $exists_element['node_id'];
			}
		}
		if(!$element_id) {
			$element_id = $this->model_module_oc_menu->createElement($element, $parent_element_id);
			$this->menu_tmp[] = array(
				'node_id' => $element_id,
				'node_tmp_id' => $element['node_tmp_id'],
			);
		}
		return $element_id;
	}
	
	private function processElements($data) {
		if(!empty($data)) {
			foreach ($data as $element) {
				if(!empty($element)) {
					if(isset($element['delete']) && $element['delete']) {
						$this->model_module_oc_menu->deleteElement($element['menu_id']);
					} else {
						$this->model_module_oc_menu->updateElement($element['menu_id'], $element);
					}
				}
			}
		}
	}
	
	public function uploadIcon() {
		$uploaded = $this->upload('element_icon_file', DIR_IMAGE . 'data/menu', 'txt,jpg,jpeg,gif,png');
		
		
		if ($uploaded[1] == '') {
			$file = $uploaded[0];
			$arr = explode('_', $file, 2);
			exit(json_encode(array(
				'status' => 201,
				'id' => $arr[0],
				'responseText' => 'success',
				'fileName' => '/image/data/menu/' . $file,
			)));
		} else {
			header('HTTP/1.1 415 BAD REQUEST', true, 415);
			exit(json_encode(array(
				'status' => 415,
				'id' => null,
				'responseText' => $uploaded[1],
			)));
		}
	}
	
	/**
	 * DANGER!! This method is realy suck and i dont want to refactor this code...
	 * @param number $file_id
	 * @param string $folder
	 * @param string $types
	 * @return multitype:string unknown |multitype:unknown string
	 */
	private function upload($file_id, $folder="", $types="") {
	    if(!$_FILES[$file_id]['name']) return array('','No file specified', $file_id);
	
	    $file_title = $_FILES[$file_id]['name'];
	    //Get file extension
	    $ext_arr = explode("\.",basename($file_title));
	    $ext = strtolower($ext_arr[count($ext_arr)-1]); //Get the last extension
	
	    //Not really uniqe - but for all practical reasons, it is
	    $uniqer = substr(md5(uniqid(rand(),1)),0,5);
	    $file_name = $uniqer . '_' . $file_title;//Get Unique Name
	
	    $all_types = explode(",",strtolower($types));
	        //Where the file must be uploaded to
	    if($folder) $folder .= '/';//Add a '/' at the end of the folder
	    $uploadfile = $folder . $file_name;
	
	    $result = '';
	    //Move the file from the stored location to the new location
	    if (!move_uploaded_file($_FILES[$file_id]['tmp_name'], $uploadfile)) {
	        $result = "Cannot upload the file '".$_FILES[$file_id]['name']."'"; //Show error if any.
	        if(!file_exists($folder)) {
	            $result .= " : Folder don't exist.";
	        } elseif(!is_writable($folder)) {
	            $result .= " : Folder not writable.";
	        } elseif(!is_writable($uploadfile)) {
	            $result .= " : File not writable.";
	        }
	        $file_name = '';
	
	    } else {
	        if(!$_FILES[$file_id]['size']) { //Check if the file is made
	            @unlink($uploadfile);//Delete the Empty file
	            $file_name = '';
	            $result = "Empty file found - please use a valid file."; //Show the error message
	        } else {
	            chmod($uploadfile,0777);//Make it universally writable.
	        }
	    }
	
	    usleep(1750000);
	    return array($file_name, $result, $file_id);
	}
}