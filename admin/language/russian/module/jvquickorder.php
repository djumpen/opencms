<?php
// Heading
$_['heading_title']    					= '<b>Быстрый заказ товара</b>';

// Text
$_['text_module']      					= 'Модули';

//buttons
$_['button_save_stay']   				= 'Сохранить и остаться';

// Text Tabs
$_['tab_text_common']   				= 'Общие';
$_['tab_text_appearance']   			= 'Внешний вид';
$_['tab_text_fields']   				= 'Поля';
$_['tab_text_email']   					= 'Почта';
$_['tab_text_order']   					= 'Оформление заказа';
$_['tab_text_system_settings']   		= 'Системные настройки';

// Entry
$_['entry_offon']   					= 'Включить модуль';

$_['entry_work_in_categories']   		= 'Модуль работает в категориях';
$_['entry_in_stock']   					= 'Учитывать кол-во товара и настройку "Заказ при нехватке на складе"';

$_['entry_show_product_name_price']		= 'Отображать имя продукта и цену';
$_['entry_show_product_desc']			= 'Отображать описание продукта';
$_['entry_show_product_images']			= 'Отображать изображения продукта';

$_['entry_type_product_images']			= 'Тип изображения продукта';
$_['type_product_images_option'] =	array(
	'type_product_images_carousel'		=>	'Карусель',
	'type_product_images_oneimage'		=>	'Изображение'
);

$_['entry_title_before_form']			= 'Заголовок перед формой';
$_['entry_text_before_form']			= 'Текст перед формой';

$_['entry_show_popover']				= 'Отображать всплывающие подсказки';

$_['entry_colour_button_quickorder']	= 'Цвет кнопки "Сделать заказ" в форме быстрого заказа';
$_['colour_button_quickorder_option'] =	array(
	'btn-primary'		=>	'Синий',
	'btn-success'		=>	'Зелёный',
	'btn-warning'		=>	'Оранжевый',
	'btn-danger'		=>	'Красный',
	'btn-inverse'		=>	'Чёрный'
);

$_['entry_send_email_status']   		= 'Отправлять уведомления';
$_['entry_type_email']   				= 'Тип письма';
$_['type_email_option'] =	array(
	'type_email_text'		=>	'Текстовое',
	'type_email_html'		=>	'Html'
);

$_['entry_offon_email_admin']   		= 'Оповестить администратора магазина';
$_['entry_offon_email_additional']      = 'Дополнительные адреса для оповещений<br /><span class="help">Список дополнительных адресов для получения сообщений. (Разделяются запятыми)</span>';
$_['entry_offon_email_customer']      	= 'Оповестить покупателя<br /><span class="help">Письмо с данными о заявке будет послано покупателю только, если покупатель указал свой e-mail</span>';

$_['entry_field_user_name_title']   	= 'Поле "Имя"';
$_['entry_field_user_name_show']   		= 'Отображать поле?';
$_['entry_field_user_name_required']   	= 'Обязательное для заполнения поле?';

$_['entry_field_user_phone_title']   	= 'Поле "Телефон"';
$_['entry_field_user_phone_show']   	= 'Отображать поле?';
$_['entry_field_user_phone_required']   = 'Обязательное для заполнения поле?';
$_['entry_field_user_phone_maskedinput']= 'Маска номера телефона:<br /><br /><span class="help">Указывается в формате<br /><b>+9 (999) 999-9999</b><br /><br />Можно использовать знаки "<b>+</b>", "<b>(</b>", "<b>)</b>", "<b>-</b>" и " "(пробел).<br /><br />"<b>9</b>" используется в качестве маски цифр (0-9)<br /><br />"<b>?</b>" делает часть маски после себя необязательным для заполнения, т.е. покупатель может указать эту часть маски, а может не указать. Например, +9 999?99. Последние две цифры покупатель может указать, а может не указывать.</span>';

$_['entry_field_email_title']   		= 'Поле "Электронная почта"';
$_['entry_field_email_show']   			= 'Отображать поле?';
$_['entry_field_email_required']   		= 'Обязательное для заполнения поле?';

$_['entry_field_comment_title']   		= 'Поле "Комментарий"';
$_['entry_field_comment_show']   		= 'Отображать поле?';
$_['entry_field_comment_required']   	= 'Обязательное для заполнения поле?';

$_['entry_field_product_quantity_title']   = 'Поле "Количество товара"';
$_['entry_field_product_quantity_show']   	= 'Отображать поле?';
$_['entry_field_product_quantity_required']= 'Обязательное для заполнения поле?';

$_['entry_order_offon']   				= 'Оформлять заказ?';
$_['entry_order_name_in_admin']   		= 'Префикс имени покупателя в заказе';
$_['entry_order_status']   				= 'Статус заказа после оплаты:';

$_['entry_del_system_css_on_show']   	= 'Выключить css-стиль по-умолчанию, когда отображается форма быстрого заказа?';

//Messages
// Error
$_['error_permission'] 					= 'У Вас нет прав для изменения модуля!';

//success
$_['text_success']     					= 'Модуль успешно обновлен!';
?>