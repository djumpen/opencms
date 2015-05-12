<?php
class ModelToolImage extends Model {

	public function scale($image, $size, $axis) {
		$file = $image;
		if (!file_exists(DIR_IMAGE . $image) || !is_file(DIR_IMAGE . $image)) {
			return false;
		}
        if(!$size) {
            return $this->config->get('config_url') . 'image/' . $file;
        }

		list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $image);
		if($axis == 'x') {
			$del = $width_orig / $size;
			$new_height = $height_orig / $del;
			$new_width = $size;
		} elseif($axis == 'y') {
			$del = $height_orig / $size;
			$new_height = $size;
			$new_width = $width_orig / $del;
		}
		return $this->resize($image, $new_width, $new_height);
	}

    /**
     *
     *	@param filename string
     *	@param width
     *	@param height
     *	@param type char [default, w, h]
     *				default = scale with white space,
     *				w = fill according to width,
     *				h = fill according to height
     *  @param short_name bool
     *
     *  @return string
     */
    public function resize($filename, $width, $height, $type = "", $short_name = false) {
        if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
            return;
        }

        $info = pathinfo($filename);

        $extension = $info['extension'];

        $old_image = $filename;
        $new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . $type .'.' . $extension;

        if (!file_exists(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
            $path = '';

            $directories = explode('/', dirname(str_replace('../', '', $new_image)));

            foreach ($directories as $directory) {
                $path = $path . '/' . $directory;

                if (!file_exists(DIR_IMAGE . $path)) {
                    @mkdir(DIR_IMAGE . $path, 0777);
                }
            }

            list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

            if ($width_orig != $width || $height_orig != $height) {
                $image = new Image(DIR_IMAGE . $old_image);

                /*if(file_exists(DIR_IMAGE . 'data/watermark/watermark.png')){
                    if ($width > 300 || $height > 200)
                    {
                        $image->watermark(DIR_IMAGE . 'data/watermark/watermark.png', 'bottomright');
                    }
                }*/

                $image->resize($width, $height, $type);
                $image->save(DIR_IMAGE . $new_image);
            } else {
                copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
            }
        }
        if($short_name) {
            return $new_image;
        }
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            return $this->config->get('config_ssl') . 'image/' . $new_image;
        } else {
            return $this->config->get('config_url') . 'image/' . $new_image;
        }
    }


    public function crop($image_name, $width, $height) {
        if(file_exists(DIR_IMAGE . $image_name)) {
            if(!$width && !$height) {
                return $this->config->get('config_url') . 'image/' . $image_name;
            }
            $image = new Image(DIR_IMAGE . $image_name);
            $info = $image->getInfo();
            $extension = pathinfo($image_name);
            $extension = $extension['extension'];
            if($info['width'] > $info['height']) {
                $type = '-horizontal-';
                $source_top_y    = 0;
                $source_bottom_y = $height;
                $source_top_x    = false;
                $source_bottom_x = false;
                $del = $info['height'] / $height;
                $new_height = $height;
                $new_width = $info['width'] / $del;
                $x_over = $new_width - $width;
                $source_top_x = $x_over/2;
                $source_bottom_x = $new_width - ($x_over/2);
            } else {
                $type = '-vertical-';
                $source_top_x     = 0;
                $source_bottom_x  = $width;
                $source_top_y 	  = false;
                $source_bottom_y  = false;
                $del = $info['width'] / $width;
                $new_height = $info['height'] / $del;
                $new_width = $width;
                $y_over = $new_height - $height;
                $source_top_y = $y_over/2;
                $source_bottom_y = $new_height - ($y_over/2);
            }
            $new_image = $this->resize($image_name, $new_width, $new_height, '', true);
            $image = new Image(DIR_IMAGE . $new_image);
            $image->crop($source_top_x, $source_top_y, $source_bottom_x, $source_bottom_y);
            $info = $image->getInfo();
            $new_image = 'cache/' . utf8_substr($image_name, 0, utf8_strrpos($image_name, '.')) . '-' . $info['width'] . 'x' . $info['height'] . $type .'.' . $extension;
            if (!file_exists(DIR_IMAGE . $new_image)) {
                $path = '';
                $directories = explode('/', dirname(str_replace('../', '', $new_image)));
                foreach ($directories as $directory) {
                    $path = $path . '/' . $directory;
                    if (!file_exists(DIR_IMAGE . $path)) {
                        @mkdir(DIR_IMAGE . $path, 0777);
                    }
                }
                $image->save(DIR_IMAGE . $new_image);
            }
            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                return $this->config->get('config_ssl') . 'image/' . $new_image;
            } else {
                return $this->config->get('config_url') . 'image/' . $new_image;
            }
        } else {
            return false;
        }
    }
}