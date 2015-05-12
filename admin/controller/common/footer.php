<?php
class ControllerCommonFooter extends Controller {   
	protected function index() {
		$this->language->load('common/footer');

		// Scripts appended to footer
		$this->data['scripts'] = $this->document->getScripts(true);
		
		// TypeScripts requiring
		if($this->document->isTsRequire()) {
			$this->data['typeScripts'] = $this->document->getTs();
		} else {
			$this->data['typeScripts'] = array();
		}

		$this->data['text_footer'] = sprintf($this->language->get('text_footer'), VERSION);

		$this->template = 'common/footer.tpl';

		$this->render();
	}
}
?>