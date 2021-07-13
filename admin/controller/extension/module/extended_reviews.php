<?php
class ControllerExtensionModuleExtendedReviews extends Controller
{
    private $error = array();
    public function index()
    {
        $this->load->language("extension/module/extended_reviews");
        $data = $this->language->all();
        $this->document->setTitle(strip_tags($this->language->get("heading_title")));
        $this->load->model("setting/setting");
        if ($this->request->server["REQUEST_METHOD"] == "POST" && $this->validate()) {
            $this->model_setting_setting->editSetting("extended_reviews", $this->request->post);
            $this->session->data["success"] = $this->language->get("text_success");
            $this->response->redirect($this->url->link("extension/module/extended_reviews", "token=" . $this->session->data["token"], true));
        }
        $data["error_warning"] = isset($this->error["warning"]) ? $this->error["warning"] : false;
        $data["success"] = isset($this->session->data["success"]) ? $this->session->data["success"] : false;
        $data["breadcrumbs"] = array(array("text" => $this->language->get("text_home"), "href" => $this->url->link("common/dashboard", "token=" . $this->session->data["token"], true)), array("text" => $this->language->get("text_extension"), "href" => $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=module", true)), array("text" => $this->language->get("heading_title"), "href" => $this->url->link("extension/module/extended_reviews", "token=" . $this->session->data["token"], true)));
        $data["action"] = $this->url->link("extension/module/extended_reviews", "token=" . $this->session->data["token"], true);
        $data["token"] = $this->session->data["token"];
        $data["cancel"] = $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=module", true);
        $data["header"] = $this->load->controller("common/header");
        $data["column_left"] = $this->load->controller("common/column_left");
        $data["footer"] = $this->load->controller("common/footer");
        $data["reviews_link"] = HTTPS_CATALOG . "?route=product/allreviewspage";
        if (isset($this->error["module_header"])) {
            $data["error_header"] = $this->error["module_header"];
        } else {
            $data["error_header"] = "";
        }
        $this->load->model("localisation/language");
        $data["languages"] = $this->model_localisation_language->getLanguages();
        $key = $this->config->get("extended_reviews_settings")["key"];
        $license = true;
        $data["license"] = $license;

        if (isset($this->request->post["extended_reviews_settings"])) {
                $data["extended_reviews"] = $this->request->post["extended_reviews_settings"];
            } else {
                if ($this->config->has("extended_reviews_settings")) {
                    $data["extended_reviews"] = $this->config->get("extended_reviews_settings");
                } else {
                    $data["extended_reviews"] = array();
                }
            }
            $data["sorts"] = array($data["sort_date"] => "r.date_added", $data["sort_most_useful"] => "r.likes", $data["sort_rating"] => "r.rating", $data["sort_with_media"] => "media");
            $this->response->setOutput($this->load->view("extension/module/extended_reviews", $data));
    }
    public function deleteUnusedImages()
    {
        $this->load->model("catalog/extended_reviews");
        $images = $this->model_catalog_extended_reviews->getUnusedImages();
        $count = 0;
        foreach ($images as $image) {
            $this->model_catalog_extended_reviews->deleteImageById($image["review_image_id"]);
            $count++;
        }
        $json["count"] = $count;
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode($json));
    }
    protected function validate()
    {
        if (!$this->user->hasPermission("modify", "extension/module/extended_reviews")) {
            $this->error["warning"] = $this->language->get("error_permission");
        }
        return !$this->error;
    }
    public function install()
    {
        $this->load->model("catalog/extended_reviews");
        $this->model_catalog_extended_reviews->install();
    }
}

?>