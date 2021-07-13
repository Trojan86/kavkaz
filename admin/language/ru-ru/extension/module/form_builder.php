<?php
// Heading
$_['heading_title']						= 'Конструктор форм';

// Extension Settings
$_['help_module_locations']				= 'Вы можете вывести модуль в позиции тут';
$_['heading_module_list']				= 'Список форм';

$_['column_module_name']				= 'Название формы';
$_['column_edit_module']				= 'Редактировать';
$_['column_copy_module']				= 'Копировать';
$_['column_delete_module']				= 'Удалить';

$_['button_add_module']					= 'Создать форму';

$_['heading_create_a_new_module']		= 'Создание новой формы';
$_['heading_edit']						= 'Редактирование формы';

// General Settings
$_['tab_general_settings']				= 'Главные настройки';

$_['entry_module_status']				= 'Статус:';
$_['entry_module_name']					= 'Название формы:';

$_['heading_text_settings']				= 'Тексты (поддерживается HTML)';

$_['entry_module_heading']				= 'Заголовок:';
$_['entry_module_pre_text']				= 'Текст перед формой:';
$_['entry_module_post_text']			= 'Текст после формы:';
$_['entry_module_error_email']			= 'Текст "Неправильный Email":';
$_['entry_module_error_required']		= 'Текст "Поля обязательны":';
$_['entry_module_submit_button']		= 'Текст на кнопке "Отправить"';
$_['entry_module_please_wait']			= 'Текст "Идет отправка":';
$_['entry_module_success']				= 'Текст "Сообщение отправлено":';

$_['heading_display_settings']			= 'Настройки отображения';

$_['entry_module_layout_id']			= 'Макет:';
$_['entry_module_position']				= 'Позиция:';
$_['entry_module_sort_order']			= 'Порядок:';

$_['text_content_top']					= 'Верхняя позиция';
$_['text_column_left']					= 'Левая колонка';
$_['text_column_right']					= 'Правая колонка';
$_['text_content_bottom']				= 'Нижняя позиция';

$_['entry_module_locations']			= 'Размещение:';
$_['help_module_locations']				= 'Вы можете вывести модуль в позиции тут';

$_['entry_module_extra_css']			= 'Ваш CSS: <div class="help-text">Пример:<br /><code class="pull-right text-left">.buttons {<br /> &nbsp; &nbsp; display: none;<br />}</code></div>';

$_['help_form_page']					= '<b>Совет:</b> Как создать форму на отдельной странице:
<ol>
	<li>Создайте страницу в Каталог > Информация (специльно для формы)</li>
	<li>Назовите страницу как и форму, чтобы было понятно (необязательно)</li>
	<li>Создайте макет специально для этой страницы, в Система > Дизайн > Макеты</li>
	<li>Привяжите макет к станице, в Каталог > Информация > Редактировать (на вкдаке Дизайн)</li>
	<li>Добавте модуль Конструктор форм > Ваша форма в позицию "Нижняя позиция"</li>
</ol>
';

// Form Fields
$_['tab_form_fields']					= 'Поля формы';

$_['help_form_fields']					= '
	<ul>
		<li><b>Значение:</b> Для полей типа text, textarea, date и time fields это будет значение плейсхолдера (placeholder).<br />
		Для полей с выбором значения - введите список возможных вариатов выбора в поле, используйте разделитель ";".<br />
		Для того, чтобы значение было выбрано по умолчанию заключите его в квадратные скобки <code>[</code> параметр <code>]</code>. Для группирования значений вы можете заключить заголовок-разделитель в фигурные скобки <code>{</code> параметр <code>}</code> (он будет недоступен для выбора).</li>
		<li><b>Значение "Другое":</b>  Текст параметра "Другое" в списке выбора. После нажатия на "Другое" появиться поле для ввода своего варианта. Оставьте поле пустым, чтобы не использовать его.</li>
	</ul>
';

$_['column_action']						= 'Действие';
$_['column_sort_order']					= 'Порядок';
$_['column_type']						= 'Тип поля';
$_['column_required']					= 'Обязательное';
$_['column_']							= '';
$_['column_title']						= 'Название';
$_['column_text']						= 'Описание';
$_['column_responses']					= 'Значение';
$_['column_other_response']				= 'Значение "Другое"';

$_['group_single_response']				= 'Одиночный выбор';
$_['text_radio_buttons']				= 'Radio переключатель';
$_['text_select_dropdown']				= 'Select выпадающий список';

$_['group_multiple_response']			= 'Множественный выбор';
$_['text_checkboxes']					= 'Checkbox - галочки';
$_['text_multiselect_box']				= 'Multi-Select Box';

$_['group_freeform_response']			= 'Текстовые поля';
$_['text_email_field']					= 'E-mail - поле ввода почты';
$_['text_text_field']					= 'Text - поле ввода теста';
$_['text_textarea_field']				= 'Textarea - текстовое поле';

$_['group_datetime_response']			= 'Дата и время';
$_['text_date_field']					= 'Выбор даты';
$_['text_time_field']					= 'Выбор времени';

$_['button_add_field']					= 'Добавить поле';

// E-mail Settings
$_['tab_email_settings']				= 'Настройки отправки';

$_['help_email_shortcodes']				= '
	<div class="well">
		Используйте шорткоды в тексте для подставления значений из настроек сайта:<br /><br />
		<table style="width: 100%; font-family: monospace">
			<tr><td>
				[store_name]<br />
				[store_url]<br />
				[store_owner]<br />
				[store_address]<br />
			</td><td>
				[store_email]<br />
				[store_telephone]<br />
				[store_fax]<br />
				[customer_ip]<br />
			</td><td>
				[current_date]<br />
				[current_time]<br />
				[form_name]<br />
				[form_responses]<br />
			</td></tr>
		</table>
	</div>
';
$_['entry_module_admin_email']			= 'E-mail получателя: <div class="help-text">Можно ввести несколько адресов и разделить их запятыми ",".</div>';
$_['entry_module_admin_subject']		= 'Заголовок письма:';
$_['entry_module_admin_message']		= 'Текст письма:';
$_['entry_module_customer_email']		= 'Отправлять сообщение отправителю: <div class="help-text">Копия сообщения отправителю. Возможно только, если в форме есть поле типа Email</div>';
$_['entry_module_customer_subject']		= 'Заголовок письма отправителю:';
$_['entry_module_customer_message']		= 'Текст письма отправителю:';

// Restrictions
$_['tab_restrictions']					= 'Разрешения';

$_['entry_module_stores']				= 'Магазины:';
$_['entry_module_languages']			= 'Языки:';
$_['entry_module_customer_groups']		= 'Группы клиентов:';
$_['entry_module_currencies']			= 'Валюты:';

$_['text_guests']						= '<em>Незарегистрированные</em>';

// Text
$_['copyright']							= '<hr /><div style="background: #20acda;color: #ffffff;font-size: 125%;padding: 10px;border-color: #1978ab;border-radius: 3px;margin: 20px;">Еще больше модулей и шаблонов для Opencart 2.x <a style="color: #fffc00;" href="https://opencart2x.ru/">на нашем сайте</a>!</div>';

$_['standard_autosaving_enabled']		= 'Автосохранение включено!';
$_['standard_confirm']					= 'Эта операция невозвратима. Продолжить?';
$_['standard_error']					= '<strong>Ошибка:</strong> У вас нет доступа к модулю ' . $_['heading_title'] . '!';
$_['standard_max_input_vars']			= '<strong>Внимание:</strong> Количество переменных превышает допустимое в переменной <code>max_input_vars</code> на вашем сервере. Обратитесь в поддержку хостинга или включите Автосохранение.';
$_['standard_please_wait']				= 'Подождите...';
$_['standard_saved']					= 'Сохранено!';
$_['standard_saving']					= 'Сохранение...';
$_['standard_select']					= '--- Выберите ---';
$_['standard_success']					= 'Успешно!';
$_['standard_testing_mode']				= 'Необходимо очистить лог. Он занимает слишком много места.';
$_['standard_vqmod']					= '';

$_['standard_module']					= 'Модули';
$_['standard_shipping']					= 'Доставка';
$_['standard_payment']					= 'Оплата';
$_['standard_total']					= 'Сумма заказа';
$_['standard_feed']						= 'Ленты';
?>