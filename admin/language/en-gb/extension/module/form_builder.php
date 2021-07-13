<?php
// Heading
$_['heading_title']						= 'Form Constructor';

// Extension Settings
$_['help_module_locations']				= 'You can set your module locations in';
$_['heading_module_list']				= 'Module List';

$_['column_module_name']				= 'Module Name';
$_['column_edit_module']				= 'Edit Module';
$_['column_copy_module']				= 'Copy Module';
$_['column_delete_module']				= 'Delete Module';

$_['button_add_module']					= 'Add Module';

$_['heading_create_a_new_module']		= 'Create a New Module';
$_['heading_edit']						= 'Edit';

//------------------------------------------------------------------------------
// General Settings
//------------------------------------------------------------------------------
$_['tab_general_settings']				= 'General Settings';

$_['entry_module_status']				= 'Status: <div class="help-text">Choose whether to enable or disable the module.</div>';
$_['entry_module_name']					= 'Name: <div class="help-text">Enter a name for the module, for admin reference only.</div>';

$_['heading_text_settings']				= 'Text Settings';

$_['entry_module_heading']				= 'Heading: <div class="help-text">Enter the heading text for the form module box. HTML is supported.</div>';
$_['entry_module_pre_text']				= 'Pre-Form Text: <div class="help-text">Optionally enter the text displayed before the form. HTML is supported.</div>';
$_['entry_module_post_text']			= 'Post-Form Text: <div class="help-text">Optionally enter the text displayed after the form. HTML is supported.</div>';
$_['entry_module_error_email']			= 'E-mail Error Message: <div class="help-text">Enter the error message displayed when the customer does not fill in a valid e-mail address for E-mail fields.</div>';
$_['entry_module_error_required']		= 'Required Error Message: <div class="help-text">Enter the error message displayed when the customer does not fill in all the required fields.</div>';
$_['entry_module_submit_button']		= 'Submit Button Text: <div class="help-text">Enter the button text displayed for the Submit button. HTML is supported.</div>';
$_['entry_module_please_wait']			= 'Please Wait Message: <div class="help-text">Enter the button text displayed while the form is being submitted. HTML is supported.</div>';
$_['entry_module_success']				= 'Success Message: <div class="help-text">Enter the message displayed after the form has been successfully submitted.</div>';

$_['heading_display_settings']			= 'Display Settings';

$_['entry_module_layout_id']			= 'Layout:';
$_['entry_module_position']				= 'Position:';
$_['entry_module_sort_order']			= 'Sort Order:';

$_['text_content_top']					= 'Content Top';
$_['text_column_left']					= 'Column Left';
$_['text_column_right']					= 'Column Right';
$_['text_content_bottom']				= 'Content Bottom';

$_['entry_module_locations']			= 'Module Locations:';
$_['help_module_locations']				= 'You can set your module locations in';

$_['entry_module_extra_css']			= 'Extra CSS: <div class="help-text">Optionally enter some CSS that is loaded along with the form. This can be used, for instance, to hide the "Continue" button on an information page dedicated to the form. That would require some CSS like this:<br /><code class="pull-right text-left">.buttons {<br /> &nbsp; &nbsp; display: none;<br />}</code></div>';

$_['help_form_page']					= '<b>Tip:</b> To dedicate a page to a form, follow these steps:
<ol>
	<li>Create an information page specifically for the form, in Catalog > Information</li>
	<li>Use the form heading as the Title, and some spaces as the description</li>
	<li>Create a layout specifically for the form, in System > Design > Layouts</li>
	<li>Assign the layout to the information page, in Catalog > Information > Edit (in the Design tab)</li>
	<li>Assign the module to that layout, using a "Content Bottom" position</li>
</ol>
';

//------------------------------------------------------------------------------
// Form Fields
//------------------------------------------------------------------------------
$_['tab_form_fields']					= 'Form Fields';

$_['help_form_fields']					= '
	<ul>
		<li><b>Sort Order:</b> Enter the sort order for the question, in relation to other questions. Make sure to use a unique value for each question.</li>
		<li><b>Type:</b> Choose the question type.</li>
		<li><b>Required:</b> Select whether a response for the question is required.</li>
		<br />
		<li><b>Title:</b> Enter the title for the field. HTML is supported.</li>
		<li><b>Text:</b> Optionally enter some text displayed below the Title. Usually this is a short explanation, or to give extra info. HTML is supported.</li>
		<br />
		<li><b>Responses:</b> Enter a list of possible responses separated by ; (semi-colons). For text, textarea, date, and time fields, entering something here will show it as the placeholder for that field.<br />To have a response selected by default, enter it in <code>[</code> and <code>]</code> characters (square brackets). For grouping purposes, you can enter a non-selectable response inside <code>{</code> and <code>}</code> characters (curly brackets).</li>
		<li><b>"Other" Response:</b> For fields with selectable responses, if you want to include a customer-editable "Other" response, fill in the text displayed in the list of response choices (e.g. "Other:"). Leave blank to not include an "Other" response.</li>
	</ul>
';

$_['column_action']						= 'Action';
$_['column_sort_order']					= 'Sort Order';
$_['column_type']						= 'Type';
$_['column_required']					= 'Required';
$_['column_']							= '';
$_['column_title']						= 'Title';
$_['column_text']						= 'Text';
$_['column_responses']					= 'Responses';
$_['column_other_response']				= '"Other" Response';

$_['group_single_response']				= 'Single Response Fields';
$_['text_radio_buttons']				= 'Radio Buttons';
$_['text_select_dropdown']				= 'Select Dropdown';

$_['group_multiple_response']			= 'Multiple Response Fields';
$_['text_checkboxes']					= 'Checkboxes';
$_['text_multiselect_box']				= 'Multi-Select Box';

$_['group_freeform_response']			= 'Freeform Response Fields';
$_['text_email_field']					= 'E-mail Field';
$_['text_text_field']					= 'Text Field';
$_['text_textarea_field']				= 'Textarea Field';

$_['group_datetime_response']			= 'Date/Time Response Fields';
$_['text_date_field']					= 'Date Field';
$_['text_time_field']					= 'Time Field';

$_['button_add_field']					= 'Add Field';

//------------------------------------------------------------------------------
// E-mail Settings
//------------------------------------------------------------------------------
$_['tab_email_settings']				= 'E-mail Settings';

$_['help_email_shortcodes']				= '
	<div class="well">
		To insert variable information, you can use the following list of shortcodes:<br /><br />
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
$_['entry_module_admin_email']			= 'Admin E-mail Address(es): <div class="help-text">Enter the e-mail address(es) where form responses are sent, separated by , (commas).</div>';
$_['entry_module_admin_subject']		= 'Admin E-mail Subject:';
$_['entry_module_admin_message']		= 'Admin E-mail Message:';
$_['entry_module_customer_email']		= 'E-mail Customer Their Responses: <div class="help-text">Select whether to e-mail the customer a copy of their responses, if the form includes an "E-mail Field".</div>';
$_['entry_module_customer_subject']		= 'Customer E-mail Subject:';
$_['entry_module_customer_message']		= 'Customer E-mail Message:';

//------------------------------------------------------------------------------
// Restrictions
//------------------------------------------------------------------------------
$_['tab_restrictions']					= 'Restrictions';

$_['entry_module_stores']				= 'Store(s): <div class="help-text">Select the stores where this module will appear.</div>';
$_['entry_module_languages']			= 'Language(s): <div class="help-text">Select the languages for which this module will appear.</div>';
$_['entry_module_customer_groups']		= 'Customer Group(s): <div class="help-text">Select the customer groups for which this module will appear. The "Guests" checkbox applies to all customers not logged in to an account.</div>';
$_['entry_module_currencies']			= 'Currencies: <div class="help-text">Select the currencies for which this module will appear.</div>';

$_['text_guests']						= '<em>Guests</em>';

//------------------------------------------------------------------------------
// Standard Text
//------------------------------------------------------------------------------
$_['copyright']							= '<hr /><div style="background: #20acda;color: #ffffff;font-size: 125%;padding: 10px;border-color: #1978ab;border-radius: 3px;margin: 20px;">More extensions for Opencart 2.x <a style="color: #fffc00;" href="https://opencart2x.ru/">on our site</a>!</div>';

$_['standard_autosaving_enabled']		= 'Auto-Saving Enabled';
$_['standard_confirm']					= 'This operation cannot be undone. Continue?';
$_['standard_error']					= '<strong>Error:</strong> You do not have permission to modify ' . $_['heading_title'] . '!';
$_['standard_max_input_vars']			= '<strong>Warning:</strong> The number of settings is close to your <code>max_input_vars</code> server value. You should enable auto-saving to avoid losing any data.';
$_['standard_please_wait']				= 'Please wait...';
$_['standard_saved']					= 'Saved!';
$_['standard_saving']					= 'Saving...';
$_['standard_select']					= '--- Select ---';
$_['standard_success']					= 'Success!';
$_['standard_testing_mode']				= 'Your log is too large to open! Clear it first, then run your test again.';
$_['standard_vqmod']					= '';

$_['standard_module']					= 'Modules';
$_['standard_shipping']					= 'Shipping';
$_['standard_payment']					= 'Payments';
$_['standard_total']					= 'Order Totals';
$_['standard_feed']						= 'Feeds';
?>