<?php 
class ControllerAccountLogout extends Controller {
	public function index() {
		if ($this->customer->isLogged()) {
            $this->customer->logout();

            $this->redirect('/', '', 'SSL');
            return;
        }
        $this->redirect('/', '', 'SSL');
	}
}
?>