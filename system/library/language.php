<?php
class Language {
	private $default = 'english';
	private $directory;
	private $data = array();
	
	private $group_data = array();

	public function __construct($directory) {
		$this->directory = $directory;
	}

	public function get($key) {
		return (isset($this->data[$key]) ? $this->data[$key] : $key);
	}

	public function load($filename) {
		$file = DIR_LANGUAGE . $this->directory . '/' . $filename . '.php';

		if (file_exists($file)) {
			$_ = array();

			require($file);

			$this->data = array_merge($this->data, $_);
			
			$filename = str_replace('/', '_', $filename);
			$filename = str_replace($this->directory, 'default', $filename);
			$this->group_data[$filename] = $_;

			return $this->data;
		}

		$file = DIR_LANGUAGE . $this->default . '/' . $filename . '.php';

		if (file_exists($file)) {
			$_ = array();

			require($file);

			$this->data = array_merge($this->data, $_);
			
			$filename = str_replace('/', '_', $filename);
			$this->group_data[$filename] = $_;

			return $this->data;
		} else {
			trigger_error('Error: Could not load language ' . $filename . '!');
		//	exit();
		}
	}
	
	public function getData() {
		return $this->data;
	}

    public function getGroupData($group = ''){
        foreach($this->group_data as $groups => $langs){
            foreach($langs as $key => $value){
                $value = str_replace("\n", '', $value);
                $value = str_replace("\r", '', $value);
                $value = addslashes($value);
                $this->group_data[$groups][$key] = $value;
            }
        }

        if(!$group || !isset($this->group_data[$group])){
            return $this->group_data;
        } else {
            return $this->group_data[$group];
        }
    }
}
?>
