<?php
class ControllerToolUpload2 extends Controller { 
	private $error = array();
 
	public function index() {
		
		$multi_dir='data/';
		$multi_dir.=date("Y")."/";
		if (!is_dir ( DIR_IMAGE.$multi_dir )) {
			mkdir( DIR_IMAGE.$multi_dir, 0777);
		}
		
		if (!is_dir ( DIR_IMAGE.$multi_dir )) {
			mkdir( DIR_IMAGE.$multi_dir, 0777);
		}
		$multi_dir.=date("m")."/";
		if (!is_dir ( DIR_IMAGE.$multi_dir )) {
			mkdir( DIR_IMAGE.$multi_dir, 0777);
		}
		
		$uploaded = $this->upload('image_file', DIR_IMAGE . $multi_dir, 'txt,jpg,jpeg,gif,png');
		
		if ($uploaded[1] == '') {
			$file = $uploaded[0];
			$arr = explode('_', $file, 2);
			exit(json_encode(array(
					'status' => 201,
					'id' => $arr[0],
					'responseText' => 'success',
					'fileName' => $multi_dir . $file,
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
	
	private function upload($file_id, $folder="", $types="") {
		
		if(!$_FILES[$file_id]['name']) return array('','No file specified', $file_id);
	
		clearstatcache();
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
				$result .= " : Folder not writable1." . $folder;
			} elseif(!is_writable($uploadfile)) {
				$result .= " : File not writable2." . $uploadfile;
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
	
		
		usleep(175000);
		return array($file_name, $result, $file_id);
	}
	
}