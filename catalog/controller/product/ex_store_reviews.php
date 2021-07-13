<?php

class ControllerProductExStoreReviews extends Controller
{
    public function index()
    {
        $settings = $this->config->get("ex_store_reviews_settings");
        if (isset($settings["license"]) && $settings["status"]) {
            if ($settings["dropzone"]) {
                $this->document->addStyle("catalog/view/javascript/ex-reviews/dropzone/min/dropzone.min.css");
                $this->document->addScript("catalog/view/javascript/ex-reviews/dropzone/min/dropzone.min.js");
                $this->document->addScript("catalog/view/javascript/ex-reviews/dropzone/min/exif.min.js");
            }
            if ($settings["carousel"]) {
                $this->document->addStyle("catalog/view/javascript/ex-reviews/owl-carousel/owl.carousel.css");
                $this->document->addScript("catalog/view/javascript/ex-reviews/owl-carousel/owl.carousel.min.js");
            }
            if ($settings["magnific"]) {
                $this->document->addStyle("catalog/view/javascript/ex-reviews/magnific/magnific-popup.css");
                $this->document->addScript("catalog/view/javascript/ex-reviews/magnific/jquery.magnific-popup.min.js");
            }
            if ($settings["bootstrap_css"]) {
                $this->document->addStyle("catalog/view/javascript/ex-reviews/bootstrap/css/bootstrap.min.css");
            }
            if ($settings["bootstrap_js"]) {
                $this->document->addScript("catalog/view/javascript/ex-reviews/bootstrap/js/bootstrap.min.js");
            }
            $this->document->addStyle("catalog/view/javascript/ex-reviews/extended_reviews.css");
            $this->load->language("product/extended_reviews");
            $data = $this->language->all();
            $this->document->setTitle($data["heading_title"]);
            $this->load->model("catalog/ex_store_reviews");
            $data["ex_store_reviews"] = $settings;
            $data["breadcrumbs"] = array();
            $data["breadcrumbs"][] = array("text" => $this->language->get("text_home"), "href" => $this->url->link("common/home"), "separator" => false);
            $url = "";
            if (isset($this->request->get["page"])) {
                $page = $this->request->get["page"];
            } else {
                $page = 1;
            }
            if (isset($this->request->get["sort"])) {
                $sort = $this->request->get["sort"];
            } else {
                $sort = $settings["sort_order"];
            }
            $url .= "&sort=" . $sort;
            $data["sort"] = $sort;
            $data["sorts"] = array();
            $data["sorts"][] = array("text" => $this->language->get("sort_date"), "value" => "date_added", "href" => $this->url->link("product/ex_store_reviews", "sort=date_added"));
            $data["sorts"][] = array("text" => $this->language->get("sort_most_useful"), "value" => "likes", "href" => $this->url->link("product/ex_store_reviews", "sort=likes"));
            $data["sorts"][] = array("text" => $this->language->get("sort_rating"), "value" => "rating", "href" => $this->url->link("product/ex_store_reviews", "sort=rating"));
            $data["sorts"][] = array("text" => $this->language->get("sort_with_media"), "value" => "media", "href" => $this->url->link("product/ex_store_reviews", "sort=media"));
            if ($this->customer->isLogged()) {
                $data["customer_name"] = $this->customer->getFirstName() . "&nbsp;" . $this->customer->getLastName();
            } else {
                $data["customer_name"] = "";
            }
            $data["breadcrumbs"][] = array("text" => $this->language->get("heading_title"), "href" => $this->url->link("product/ex_store_reviews", $url), "separator" => $this->language->get("text_separator"));
            $data["reviews"] = array();
            $data["text_login"] = sprintf($this->language->get("text_login"), $this->url->link("account/login", "", true), $this->url->link("account/register", "", true));
            if (!$settings["review_access"] || $this->customer->isLogged()) {
                $data["review_guest"] = true;
            } else {
                $data["review_guest"] = false;
            }
            if (!$settings["likes_access"] || $this->customer->isLogged()) {
                $data["likes_guest"] = true;
            } else {
                $data["likes_guest"] = false;
            }
            if (!$settings["answer_access"] || $this->customer->isLogged()) {
                $data["answer_guest"] = true;
            } else {
                $data["answer_guest"] = false;
            }
            $data["error_too_big"] = sprintf($this->language->get("error_too_big"), $settings["image_max_size"]);
            $data["error_max_files"] = sprintf($this->language->get("error_max_files"), $settings["image_max_count"]);
            $data["module_header"] = $settings["module_header"][$this->config->get("config_language_id")];
            $data["module_url"] = $this->url->link("product/ex_store_reviews");
            $image_width = $settings["image_width"];
            $image_height = $settings["image_height"];
            $limit = isset($settings["limit"]) ? $settings["limit"] : 10;
            $review_total = $this->model_catalog_ex_store_reviews->getTotalReviews();
            $results = $this->model_catalog_ex_store_reviews->getReviews(($page - 1) * $limit, $limit, $sort);
            $total_children_reviews = $this->model_catalog_ex_store_reviews->getChildrenReviews();
            $total_videos = $this->model_catalog_ex_store_reviews->getAllVideos();
            $review_images_total = $this->model_catalog_ex_store_reviews->getAllImages();
            $videos_id = array();
            if (!empty($total_videos)) {
                foreach ($total_videos as $videos) {
                    foreach ($videos as $video) {
                        $str = explode(" ", $video);
                        foreach ($str as $vid) {
                            $videos_id[] = $vid;
                        }
                    }
                }
            }
            $data["total_videos"] = $videos_id;
            $this->load->model("tool/image");
            $total_review_images = array();
            foreach ($review_images_total as $image) {
                $type = "0";
                $id = $image["review_id"];
                if ($image["image"] != NULL) {
                    $popup = "image/" . $image["image"];
                    $thumb = $this->model_tool_image->resize($image["image"], $settings["thumb_width"] * 2, $settings["thumb_height"] * 2);
                } else {
                    if ($image["image_href"] != NULL) {
                        $popup = $image["image_href"];
                        $thumb = $image["image_href_t"];
                        $type = "1";
                    }
                }
                $total_review_images[$id][] = array("thumb" => $thumb, "popup" => $popup, "image_id" => $image["review_image_id"], "type" => $type);
            }
            $data["total_images"] = $total_review_images;
            foreach ($results as $result) {
                if (!empty($total_review_images[$result["review_id"]])) {
                    $images = $total_review_images[$result["review_id"]];
                } else {
                    $images = NULL;
                }
                $videos = array();
                if (!empty($result["videos"])) {
                    $str = explode(" ", $result["videos"]);
                    foreach ($str as $video) {
                        $videos[] = $video;
                    }
                }
                $children_reviews = array();
                if (!empty($total_children_reviews)) {
                    foreach ($total_children_reviews as $review) {
                        if ($review["parent_id"] == $result["review_id"]) {
                            $review["date_added"] = date($this->language->get("date_format_short"), strtotime($review["date_added"]));
                            $children_reviews[] = $review;
                        }
                    }
                }
                $data["reviews"][] = array("review_id" => $result["review_id"], "parent_id" => $result["parent_id"], "author" => $result["author"], "text" => nl2br($result["text"]), "admin_name" => nl2br($result["admin_name"]), "admin_reply" => nl2br($result["admin_reply"]), "plus" => nl2br($result["plus"]), "minus" => nl2br($result["minus"]), "images" => $images, "videos" => $videos, "children_reviews" => $children_reviews, "rating" => (int) $result["rating"], "likes" => (int) $result["likes"], "dislikes" => (int) $result["dislikes"], "date_added" => date($this->language->get("date_format_short"), strtotime($result["date_added"])));
            }
            if ($settings["captcha"]) {
                $data["captcha"] = $this->load->controller("extension/captcha/google_captcha");
            } else {
                $data["captcha"] = "";
            }
            $pagination = new Pagination();
            $pagination->total = $review_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link("product/ex_store_reviews", "page={page}" . $url);
            $data["pagination"] = $pagination->render();
            $data["results"] = sprintf($this->language->get("text_pagination"), $review_total ? ($page - 1) * $limit + 1 : 0, $review_total - $limit < ($page - 1) * $limit ? $review_total : ($page - 1) * $limit + $limit, $review_total, ceil($review_total / $limit));
            $data["column_left"] = $this->load->controller("common/column_left");
            $data["column_right"] = $this->load->controller("common/column_right");
            $data["content_top"] = $this->load->controller("common/content_top");
            $data["content_bottom"] = $this->load->controller("common/content_bottom");
            $data["footer"] = $this->load->controller("common/footer");
            $data["header"] = $this->load->controller("common/header");
            $this->response->setOutput($this->load->view("product/ex_store_reviews", $data));
        }
    }
    public function write()
    {
        $this->load->language("product/extended_reviews");
        $config = $this->config->get("ex_store_reviews_settings");
        $json = array();
        if (empty($this->request->post["rating"]) || $this->request->post["rating"] < 0 || 5 < $this->request->post["rating"]) {
            $json["error"] = $this->language->get("error_rating");
        }
        if ($this->request->server["REQUEST_METHOD"] == "POST") {
            if (utf8_strlen($this->request->post["name"]) < 3 || 35 < utf8_strlen($this->request->post["name"])) {
                $json["error"] = $this->language->get("error_name");
            }
            if (utf8_strlen($this->request->post["text"]) < 5 || 5000 < utf8_strlen($this->request->post["text"])) {
                $json["error"] = $this->language->get("error_text");
            }
            if ($config["captcha"]) {
                $captcha = $this->load->controller("extension/captcha/google_captcha/validate");
                if ($captcha) {
                    $json["error"] = $captcha;
                }
            }
            if (!isset($json["error"])) {
                $this->load->model("catalog/ex_store_reviews");
                if ($config["automoderate"]) {
                    $review_id = $this->model_catalog_ex_store_reviews->addReview($this->request->post, "1");
                    $json["success"] = $this->language->get("text_success");
                    if ($config["reward"]) {
                        if (!empty($this->request->post["video_links"])) {
                            $this->model_catalog_ex_store_reviews->addBonus($review_id, $config["bonus_video"], $this->language->get("text_store_video_bonus"));
                        } else {
                            if (!empty($this->request->post["image_id"])) {
                                $this->model_catalog_ex_store_reviews->addBonus($review_id, $config["bonus_photo"], $this->language->get("text_store_photo_bonus"));
                            } else {
                                $this->model_catalog_ex_store_reviews->addBonus($review_id, $config["bonus"], $this->language->get("text_store_bonus"));
                            }
                        }
                    }
                } else {
                    $this->model_catalog_ex_store_reviews->addReview($this->request->post);
                    $json["success"] = $this->language->get("text_success");
                }
            }
        }
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    public function writeAnswer()
    {
        $this->load->language("product/extended_reviews");
        $json = array();
        if ($this->request->server["REQUEST_METHOD"] == "POST") {
            if (utf8_strlen($this->request->post["name"]) < 3 || 100 < utf8_strlen($this->request->post["name"])) {
                $json["error"] = $this->language->get("error_name");
            }
            if (utf8_strlen($this->request->post["text"]) < 5 || 5000 < utf8_strlen($this->request->post["text"])) {
                $json["error"] = $this->language->get("error_text");
            }
            if ($this->config->get("ex_store_reviews_settings")["captcha"]) {
                $captcha = $this->load->controller("extension/captcha/google_captcha/validate");
                if ($captcha) {
                    $json["error"] = $captcha;
                }
            }
            if (!isset($json["error"])) {
                $this->load->model("catalog/ex_store_reviews");
                if ($this->config->get("ex_store_reviews_settings")["automoderate"]) {
                    $this->model_catalog_ex_store_reviews->addReviewAnswer($this->request->get["parent_id"], $this->request->post, "1");
                    $json["success"] = $this->language->get("text_success");
                } else {
                    $this->model_catalog_ex_store_reviews->addReviewAnswer($this->request->get["parent_id"], $this->request->post);
                    $json["success"] = $this->language->get("text_success");
                }
            }
        }
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    public function plusReviewRating()
    {
        $this->load->language("product/extended_reviews");
        $this->load->model("catalog/ex_store_reviews");
        $json = array();
        $this->model_catalog_ex_store_reviews->ratingPlus($this->request->post["review_id"]);
        $config = $this->config->get("ex_store_reviews_settings");
        if ($config["likes_reward"]) {
            $this->model_catalog_ex_store_reviews->addBonusForLike($this->request->post["review_id"], $config["bonus_likes"]);
        }
        $json["success"] = $this->language->get("text_success");
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    public function minusReviewRating()
    {
        $this->load->language("product/extended_reviews");
        $this->load->model("catalog/ex_store_reviews");
        $json = array();
        $this->model_catalog_ex_store_reviews->ratingMinus($this->request->post["review_id"]);
        $json["success"] = $this->language->get("text_success");
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    public function deleteImage()
    {
        $this->load->model("catalog/ex_store_reviews");
        $this->model_catalog_ex_store_reviews->deleteImageById($this->request->post["image_id"]);
        $json["success"] = $this->language->get("text_success");
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    public function getToken($length)
    {
        $token = "";
        $codeAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        $codeAlphabet .= "abcdefghijklmnopqrstuvwxyz";
        $codeAlphabet .= "0123456789";
        $max = strlen($codeAlphabet);
        for ($i = 0; $i < $length; $i++) {
            $token .= $codeAlphabet[rand(0, $max - 1)];
        }
        return $token;
    }
    public function check()
    {
        $settings = $this->config->get("ex_store_reviews_settings");
        $this->load->language("tool/upload");
        $this->load->language("product/extended_reviews");
        $json = array();
        $limitBytes = 1024 * 1024 * $settings["image_max_size"];
        $limitWidth = $settings["image_max_width"];
        $limitHeight = $settings["image_max_height"];
        if (!empty($this->request->files["file"]["name"]) && is_file($this->request->files["file"]["tmp_name"])) {
            $filename = basename(preg_replace("/[^a-zA-Z0-9\\.\\-\\s+]/", "", html_entity_decode($this->request->files["file"]["name"], ENT_QUOTES, "UTF-8")));
            if (utf8_strlen($filename) < 3 || 64 < utf8_strlen($filename)) {
                $json["error"] = $this->language->get("error_filename");
            }
            $allowed = array("jpeg", "jpg", "png");
            if (!in_array(strtolower(substr(strrchr($filename, "."), 1)), $allowed)) {
                $json["error"] = $this->language->get("error_filetype");
            }
            $allowed = array("image/jpeg", "image/png");
            if (!in_array($this->request->files["file"]["type"], $allowed)) {
                $json["error"] = $this->language->get("error_filetype");
            }
            $content = file_get_contents($this->request->files["file"]["tmp_name"]);
            if (preg_match("/\\<\\?php/i", $content)) {
                $json["error"] = $this->language->get("error_filetype");
            }
            if ($this->request->files["file"]["error"] != UPLOAD_ERR_OK) {
                $json["error"] = $this->language->get("error_upload_" . $this->request->files["file"]["error"]);
            }
        } else {
            $json["error"] = $this->language->get("error_upload");
        }
        $image_info = getimagesize($this->request->files["file"]["tmp_name"]);
        $mime = (string) $image_info["mime"];
        if (strpos($mime, "image") === false) {
            $json["error"] = $this->language->get("error_only_images");
        }
        if ($limitBytes < filesize($this->request->files["file"]["tmp_name"])) {
            $json["error"] = sprintf($this->language->get("error_too_big"), $limitBytes);
        }
        if ($limitHeight < $image_info[1]) {
            $json["error"] = sprintf($this->language->get("error_max_height"), $limitHeight);
        }
        if ($limitWidth < $image_info[0]) {
            $json["error"] = sprintf($this->language->get("error_max_width"), $limitWidth);
        }
        if (!$json) {
            $this->load->model("catalog/ex_store_reviews");
            if (!$settings["photo_hosting"]) {
                $name = $this->getToken(10);
                $extension = image_type_to_extension($image_info[2]);
                $format = str_replace("jpeg", "jpg", $extension);
                $file = $name . $format;
                move_uploaded_file($this->request->files["file"]["tmp_name"], DIR_IMAGE . "catalog/extended-reviews/" . $filename);
                $exif = @exif_read_data(DIR_IMAGE . "catalog/extended-reviews/" . $filename);
                $image = new Image(DIR_IMAGE . "catalog/extended-reviews/" . $filename);
                unlink(DIR_IMAGE . "catalog/extended-reviews/" . $filename);
                $image->resize($image_info[0] * 0.9, $image_info[1] * 0.9);
                if (!empty($exif["Orientation"])) {
                    switch ($exif["Orientation"]) {
                        case 8:
                            $image->rotate(90);
                            break;
                        case 3:
                            $image->rotate(180);
                            break;
                        case 6:
                            $image->rotate(-90);
                            break;
                    }
                }
                $image->save(DIR_IMAGE . "catalog/extended-reviews/" . $file);
                $json["image_id"] = $this->model_catalog_ex_store_reviews->addUploadImage("catalog/extended-reviews/" . $file);
                $json["success"] = $this->language->get("text_upload");
            } else {
                $api_url = "https://api.imgbb.com/1/upload?key=" . $settings["api_key"];
                $str = file_get_contents($this->request->files["file"]["tmp_name"]);
                $base64 = base64_encode($str);
                $str = http_build_query(array("image" => $base64));
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $api_url);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $str);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                $server_output = curl_exec($ch);
                curl_close($ch);
                $server_output = json_decode($server_output, true);
                $json["server_out"] = $server_output["data"];
                $json["image_id"] = $this->model_catalog_ex_store_reviews->addHostingImage($server_output["data"]);
                $json["success"] = $this->language->get("text_upload");
            }
        }
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
}

?>