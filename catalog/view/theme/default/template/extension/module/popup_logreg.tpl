<?php if($popup_logreg_login){ ?>
<div id="popuplogin">
	<div class="popup__btn-close popup-close">
		<span class="btn-close"  onclick="$('#popuplogin').popup('hide')" class="close" alt="Закрыть"></span>
	</div>
	<div class="popup__box">
		<img class="logIn__bd-top" src="catalog/view/theme/default/img/bg-popup-top-logIn.png" alt="image">
		<img class="logIn__bd-bottom" src="catalog/view/theme/default/img/bg-popup-bottom-logIn.png" alt="image">
		<form id="popuplogin_form" class="popup__logIn form-validation">
			<div class="popup__title"><?php echo $head_login; ?></div>
			<div class="popup__input-box">
				<p class="popup__input-placeholder"><?php echo $login_email; ?></p>
				<input class="popup__input field" type="text" name="email" class="mail_login" value="" />
			</div>
			<div class="btn__recover-password popup__btn" data-popup="recoverPassword" id="forgotten">

					<?php if($popup_logreg_login_forgotten_enable){ ?>

                        <span class="btn__recover-password popup__btn popupForgotten" data-popup="forgotten"><?php echo $login_forgotten; ?></span>


					<!--a href="index.php?route=account/forgotten">
						<?php echo $popup_logreg_login_forgotten; ?>
					</a-->
					<?php } ?>
				
			</div>
			<div id="error" class="password popup__input-box">
				<p class="popup__input-placeholder"><?php echo $login_password; ?></p>
				<input type="password" class="password-input popup__input field" name="password" value="" />
				<a class="password-control"></a>
			</div>
			<div class="but">
				<a class="popup__btn-submit btn btn-primary" id="button_login" onclick="popup_logreg_login();"><?php echo $login_button; ?></a>
			</div>
			<p class="popup__logIn-text"><?php echo $text_else; ?></p>
			<button class="popup__btn-facebook" type="button">
				<img src="catalog/view/theme/default/img/facebook.png" alt="facebook icon">
				<span>Продолжить с Facebook</span>
			</button>
			<div class="popup__registration-box">
				<span><?php echo $no_accaunt; ?></span>
				<span class="popup__btn-registration popupRegistration" data-popup="registration"><?php echo $login_register; ?></span>
			</div>
	</div>
	</form>
</div>
<?php } ?>
<?php if($popup_logreg_register){ ?>
<div id="popupregister">
	<div class="popup__btn-close popup-close">
		<span class="btn-close"  onclick="$('#popuplogin').popup('hide')" class="close" alt="Закрыть"></span>
	</div>
	<div class="popup__box">
		<form id="popupregister_form" class="popup__registration form-validation">
			<div class="popup__title"><?php echo $register_head; ?></div>
			<?php if($popup_logreg_register_firstname_show){ ?>
			<div id="firstname" class="popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_firstname; ?></p>
				<input class="popup__input field" type="text" name="firstname" class="mail_login" value="" />
			</div>
			<?php } ?>
			<?php if($popup_logreg_register_lastname_show){ ?>
			<div id="lastname" class="popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_lastname; ?></p>
				<input class="popup__input field" type="text" name="lastname" class="mail_login" value="" />
			</div>
			<?php } ?>
			<div class="popup__input-box popup__select-nav select__nav">
				<div class="popup__select select__title-box">
					<p class="popup__select-title select__title"><?php echo $text_gender; ?></p>
					<img class="select__img" src="catalog/view/theme/default/img/triangle-bl.svg" alt="triangle images">
				</div>
				<ul class="popup__select-nav-list select__nav-list">
					<li class="popup__select-nav-item select__nav-item">
						<?php echo $gender_man; ?></p>
					</li>
					<li class="popup__select-nav-item select__nav-item">
						<?php echo $gender_wooman; ?></p>
					</li>
				</ul>
			</div>
			<?php if($popup_logreg_register_phone_show){ ?>
			<div id="telephone" class="popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_phone; ?></p>
				<input class="popup__input field" type="text" id="pur_phone" name="telephone" class="mail_login" value="" />
			</div>
			<?php } ?>
			<div id="email" class="popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_email; ?></p>
				<input class="popup__input field" type="text" name="email" class="mail_login" value="" />
			</div>
			<div id="password" class="password popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_password; ?></p>
				<input class="password-input popup__input field" type="password" name="password" value="" />
				<a class="password-control"></a>
			</div>
			<?php if($popup_logreg_register_password_confirm_show){ ?>
			<div id="password_confirm" class="password popup__input-box">
				<p class="popup__input-placeholder"><?php echo $register_password_confirm; ?></p>
				<input class="password-input popup__input field" type="password" name="password_confirm" value="" />
				<a class="password-control"></a>
			</div>
			<?php } ?>
			<div class="but">
				<a class="popup__btn-submit btn btn-primary" id="button_register" onclick="popup_logreg_register();"><?php echo $register_button; ?></a>
			</div>
			<div class="popup__registration-box">
				<span>Есть аккаунт?</span>
				<span class="popup__btn-registration popuplogin" data-popup="popuplogin">Войти</span>
			</div>
	</div>
	<?php if($popup_logreg_register_group){ ?>
	<div style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
		<?php foreach ($customer_groups as $customer_group) { ?>
		<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
		<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
		<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
		<br />
		<?php } else { ?>
		<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
		<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
		<br />
		<?php } ?>
		<?php } ?>
	</div>
	<?php } ?>
	<?php if ($popup_logreg_register_iagree) { ?>
	<div>
		<?php echo $text_agree; ?> <input type="checkbox" name="agree" value="1" />
	</div>
	<?php } ?>
	</form>
</div>

<div class="popup__container recoverPassword" id="recoverpassword">
	<div class="popup__btn-close popup-close">
		<span class="btn-close"></span>
	</div>
	<div class="popup__box">
		<img class="recoverPassword__bd-top lazy" data-src="catalog/view/theme/default/img/bg-popup-top-recoverPassword.png" alt="image">
		<img class="recoverPassword__bd-bottom lazy" data-src="catalog/view/theme/default/img/bg-popup-bottom-recoverPassword.png" alt="image">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="popup__recoverPassword form-validation">
			<div class="popup__title">
				Восстановление пароля
			</div>
			<p class="popup__recoverPassword-text">Введите свою почту. Вы получите ссылку для создания нового пароля по электронной почте.</p>
			<div class="popup__input-box">
				<p class="popup__input-placeholder">Email</p>
				<input class="popup__input field" type="email" name="email">
				<p class="popup__input-error">Введите корректный email адрес</p>
			</div>
			<input class="popup__btn-submit" type="submit" value="Отправить">
			<div class="popup__registration-box">
				<span>Есть аккаунт?</span>
				<span class="popup__btn-registration popup__btn popuplogin" data-popup="popuplogin">Войти</span>
			</div>
		</form>
	</div>
	<div class="popup__level2">
		<div class="popup__title">
			Проверьте email
		</div>
		<p class="popup__recoverPassword-text">Мы оправили ссылку на ваш еmail, который вы указали. Проверьте почту и перейтите по ссылке для сброса пароля и формирования нового.</p>
	</div>
</div>

<?php } ?>
<script type="text/javascript"><!--
	$(document).ready(function() {
		$('#popuplogin, #popupregister, #recoverpassword').popup({transition: 'all 0.3s'});
		 $('#pur_phone').mask("<?php echo $popup_logreg_register_phone_mask; ?>");

	<?php if (!$logged && $popup_logreg_login) { ?>
		<?php if (!$popup_logreg_login_block_link) { ?>$('<?php echo $popup_logreg_login_block ?>').addClass('popuplogin');<?php } else { ?>$('<?php echo $popup_logreg_login_block; ?> a').last().addClass('popuplogin');<?php } ?>
		<?php } ?>
		<!-- <?php if (!$logged && $popup_logreg_register) { ?>
			<?php if (!$popup_logreg_register_block_link) { ?>$('<?php echo $popup_logreg_register_block ?>').addClass('popupregister');<?php } else { ?>$('<?php echo $popup_logreg_register_block; ?> a').first().addClass('popupregister');<?php } ?>
		<?php } ?> -->
		$('.popuplogin').bind('click', function(e) {
			console.log(11)
			e.preventDefault();
			$('#popupregister').popup('hide');
			$('#recoverpassword').popup('hide');
			$('#popuplogin').popup('show');
			$('body').addClass('overflow-hidden')
		});

		$('.popupRegistration').bind('click', function(e) {
			e.preventDefault();
			$('#popuplogin').popup('hide');
			$('#recoverpassword').popup('hide');
			$('#popupregister').popup('show');
		});
		$('.popupForgotten').bind('click', function(e) {
			e.preventDefault();
			$('#popuplogin').popup('hide');
			$('#popupregister').popup('hide');
			$('#recoverpassword').popup('show');
		});

		$('.popup-close').bind('click', function(e) {
			$('.popup_content').popup('hide');
			$('.popup_wrapper').removeClass('popup_wrapper_visible');
			$('body').removeClass('overflow-hidden')
		});


	});
	//--></script>

<script>
	$('.password').on('click touchend', '.password-control', function(){
		if ($(this).parent().find('.password-input').attr('type') == 'password'){
			$(this).addClass('view');
			$(this).parent().find('.password-input').attr('type', 'text');
		} else {
			$(this).removeClass('view');
			$(this).parent().find('.password-input').attr('type', 'password');
		}
		return false;
	});
</script>