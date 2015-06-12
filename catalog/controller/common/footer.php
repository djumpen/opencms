 <?php
class ControllerCommonFooter extends Controller {
	protected function index() {
	    
	    $this->load->model ( 'design/layout' );

	    /* Subscription script */
	    if (isset ( $this->request->get ['route'] )) {
	        $route = ( string ) $this->request->get ['route'];
	    } else {
	        $route = 'common/home';
	    }

	    $layout_id = 0;
	    

	    if (! $layout_id) {
	        $layout_id = $this->model_design_layout->getLayout ( $route );
	    }
	    
	    if (! $layout_id) {
	        $layout_id = $this->config->get ( 'config_layout_id' );
	    }

	    $module_data = array ();
	    $all_pages_layout_id = $this->model_design_layout->getLayoutForAllPages();
	    $this->load->model ( 'setting/extension' );
	    
	    $extensions = $this->model_setting_extension->getExtensions ( 'module' );
	    
	    foreach ( $extensions as $extension ) {
	        $modules = $this->config->get ( $extension ['code'] . '_module' );
	        	
	        if ($modules) {
	            foreach ( $modules as $module ) {
	                if ((($module ['layout_id'] == $layout_id) || ($module['layout_id'] == $all_pages_layout_id)) && ($module ['position'] == 'footer') && $module ['status']) {
	                    $module_data [] = array (
	                                    'code' => $extension ['code'],
	                                    'setting' => $module,
	                                    'sort_order' => $module ['sort_order']
	                    );
	                }
	            }
	        }
	    }

	    $sort_order = array ();
	    
	    foreach ( $module_data as $key => $value ) {
	        $sort_order [$key] = $value ['sort_order'];
	    }
	    
	    array_multisort ( $sort_order, SORT_ASC, $module_data );
	    
	    $this->data ['modules'] = array ();
	    
	    foreach ( $module_data as $module ) {
	        $module = $this->getChild ( 'module/' . $module ['code'], $module ['setting'] );
	        	
	        if ($module) {
	            $this->data ['modules'] [] = $module;
	        }
	    }

		$this->language->load('common/footer');

		$this->data['informations'] = array();

		$this->data['powered'] = sprintf($this->language->get('text_powered'), date('Y', time()), $this->config->get('config_name'));

		// Scripts appended to footer
		$this->data['scripts'] = $this->document->getScripts(true);

		// Styles appended to footer
		$this->data['styles'] = $this->document->getStyles(true);
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}

		$this->render();
	}
}
?>