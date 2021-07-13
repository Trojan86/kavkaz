<?php
class ControllerAccountNewsletter extends Controller
{
    public function index()
    {
        $query =$this->db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `setting_id`= 8292;" );

        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/newsletter', '', true);

            $this->response->redirect($this->url->link('account/login', '', true));
        }

        $this->load->language('account/newsletter');

        $this->document->setTitle($this->language->get('heading_title'));

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {

            $name = trim($_POST['firstname']);


            $phone = trim($_POST['phone']);
            $phone = strip_tags($phone);
            $phone = htmlspecialchars($phone);

            $mail = trim($_POST['email']);
            $mail = strip_tags($mail);
            $mail = htmlspecialchars($mail);

            $theme = trim($_POST['text']);
            $theme = strip_tags($theme);
            $theme = htmlspecialchars($theme);

            if ($name and $phone and $mail and $theme) {
                $email = $query->row['value'];
                $headers = 'MIME-Version: 1.0' . "\r\n";
                $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
                $headers .= 'From: Интернет-магазин kavkaz-ochag <site@kavkaz-ochag>' . "\r\n";
                $subject = "Обращение к директору";
                $body = "<h1>Обращение к директору</h1>";
                $body .= "<p>Пользователь: " . $name . "</p>";
                $body .= "<p>Телефон: " . $phone . "</p>";
                $body .= "<a href='mailto:" . $mail . "'>$mail</a>";
                $body .= "<p>Сообщение: " . $theme . "</p>";

                $result = mail($email, $subject, $body, $headers);
            }

            //$this->load->model('account/customer');

            //$this->model_account_customer->editNewsletter($this->request->post['newsletter']);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('account/download', '', true));
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('account/download', '', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_newsletter'),
            'href' => $this->url->link('account/newsletter', '', true)
        );

        $data['heading_title'] = $this->language->get('heading_title');
        $data['name_lastname'] = $this->language->get('name_lastname');
        $data['phone_number'] = $this->language->get('phone_number');
        $data['email_text'] = $this->language->get('email_text');
        $data['essence'] = $this->language->get('essence');

        $data['error_text'] = $this->language->get('error_text');
        $data['error_email'] = $this->language->get('error_email');

        $data['entry_newsletter'] = $this->language->get('entry_newsletter');

        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');

        $data['action'] = $this->url->link('account/newsletter', '', true);

        $data['newsletter'] = $this->customer->getNewsletter();

        $data['back'] = $this->url->link('account/download', '', true);

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('account/newsletter', $data));

    }
}