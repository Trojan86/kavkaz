<?php
class ModelToolIcon extends Model {
    public function resize($filename, $width, $height) {
        if (!is_file(DIR_IMAGE . $filename) || substr(str_replace('\\', '/', realpath(DIR_IMAGE . $filename)), 0, strlen(DIR_IMAGE)) != DIR_IMAGE) {
            return;
        }

        $extension = pathinfo($filename, PATHINFO_EXTENSION);

        $icon_old = $filename;
        $icon_new = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '.' . $extension;

        if (!is_file(DIR_IMAGE . $icon_new) || (filectime(DIR_IMAGE . $icon_old) > filectime(DIR_IMAGE . $icon_new))) {
            list($width_orig, $height_orig, $icon_type) = getimagesize(DIR_IMAGE . $icon_old);

            if (!in_array($icon_type, array(IMAGETYPE_PNG, IMAGETYPE_JPEG, IMAGETYPE_GIF))) {
                return DIR_IMAGE . $icon_old;
            }

            $path = '';

            $directories = explode('/', dirname($icon_new));

            foreach ($directories as $directory) {
                $path = $path . '/' . $directory;

                if (!is_dir(DIR_IMAGE . $path)) {
                    @mkdir(DIR_IMAGE . $path, 0777);
                }
            }

            if ($width_orig != $width || $height_orig != $height) {
                $icon = new Icon(DIR_IMAGE . $icon_old);
                $icon->resize($width, $height);
                $icon->save(DIR_IMAGE . $icon_new);
            } else {
                copy(DIR_IMAGE . $icon_old, DIR_IMAGE . $icon_new);
            }
        }

        if ($this->request->server['HTTPS']) {
            return HTTPS_CATALOG . 'image/' . $icon_new;
        } else {
            return HTTP_CATALOG . 'image/' . $icon_new;
        }
    }
}
