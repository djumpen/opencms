<?php
class Sms
{
    private $_connection;
    private $_error;
    private $_table;
    private $config;
    private $db_server = '94.249.146.189';
    
    public function __construct($registry){
    	$this->config = $registry->get('config');
    }

    public function init(){
        // Connect to remote gateway
        try {
            $this->_connection = new PDO("mysql:host=" . $this->db_server . ";dbname=" . 'users' . ";charset=UTF8", $this->config->get('config_sms_notifications_login'), $this->config->get('config_sms_notifications_password'));
            $this->_table = $this->config->get('config_sms_notifications_login');
        } catch (PDOException $e) {
            $this->_error = $e->getMessage();
            return;
        }
		
        // Set transfer encoding
        $this->_connection->query("SET NAMES utf8");
    }

    public function getConnection(){
        return $this->_connection ? $this->_connection : false;
    }

    public function send($number, $message){
    	if($this->_connection){
	    	$number = preg_replace('/[^0-9]/', '', $number);
	    	$do = false;
	    	if(strlen($number) == 9){
	    		$number = '0' . $number;
	    		$do = true;
	    	} elseif(strlen($number) == 10){
	    		$number = '38' . $number;
	    		$do = true;
	    	} elseif(strlen($number) == 12){
	    		$do = true;
	    	}
	    	if($do){
	        	$sql = "Insert Into " . $this->config->get('config_sms_notifications_login') . " Set number = '" . $this->prepareNumber($number) . "', sign = '" . $this->config->get('config_sms_notifications_sign') . "', message = '" . $this->escape($message) . "'";
	        	return $this->_connection->exec($sql);
	    	}
			return false;
    	} else {
    		return false;
    	}
    }
    
    private function prepareNumber($number) {
        // @todo Here must be a regexp, not this unreadable junk!!!
        $number = str_replace('+', '', str_replace('-', '', str_replace('(', '', str_replace(')', '', str_replace(' ', '', $number)))));
        return $this->escape($number);
    }
    
    private function escape($string) {
        return addslashes($string);
    }

}
