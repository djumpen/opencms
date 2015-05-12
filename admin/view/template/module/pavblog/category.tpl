<?php

echo $header;

$module_row=0;

?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
   <div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div id="ajaxloading" class="hide">
	<div class="warning"><b>processing request...</b></div>
  </div>
<div class="panel panel-default">
      <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
      <div class="button-group">
	  <a onclick="$('#form').submit();" class="btn btn-primary"><?php echo $button_save; ?></a>
	  <a onclick="__submit('save-edit')" class="btn btn-default"><?php echo $this->language->get('button_save_edit'); ?></a>
	  <a onclick="__submit('save-new')" class="btn btn-default"><?php echo $this->language->get('button_save_new'); ?></a>
	  <a href="<?php echo $cancel; ?>" class="btn btn-danger"><?php echo $button_cancel; ?></a></div>
    </div>
   <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<div class="megamenu row">
				<div class="tree-megamenu col-xs-4">
					
					<h4><?php echo $this->language->get('text_tree_category_menu');?></h4>
					<?php echo $tree; ?>
					<input type="button" name="serialize" id="serialize" value="Update" />
					
					<p class="note"><i><?php echo $this->language->get("text_explain_drapanddrop");?></i></p>
				</div>
				
				<div class="megamenu-form col-xs-8">
					<div id="megamenu-form">
						<?php require( "category_form.tpl" );?>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" value="" name="save_mode" id="save_mode"/>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$(".htabs a").tabs();
//--></script> 
 <script type="text/javascript" class="source below">
 function __submit( m ){
	$("#save_mode").val( m );
	$('#form').submit();
 }
	$('ol.sortable').nestedSortable({
			forcePlaceholderSize: true,
			handle: 'div',
			helper:	'clone',
			items: 'li',
			opacity: .6,
			placeholder: 'placeholder',
			revert: 250,
			tabSize: 25,
			tolerance: 'pointer',
			toleranceElement: '> div',
			maxLevels: 4,

			isTree: true,
			expandOnHover: 700,
			startCollapsed: true
		});
	
	$('#serialize').click(function(){
			var serialized = $('ol.sortable').nestedSortable('serialize');
			 $.ajax({
			async : false,
			type: 'POST',
			dataType:'json',
			url: "<?php echo str_replace("&amp;","&",$updateTree);?>",
			data : serialized, 
			success : function (r) {
				 
			}
		});
	})
	$(".quickedit").click( function(){
		
		var id = $(this).attr("rel").replace("id_","");
		$.post( "<?php echo str_replace("&amp;","&",$actionGetInfo);?>", {
			"id":id,	
			"rand":Math.random()},
			function(data){
				$("#megamenu-form").html( data );
			});
	} );
	$(".quickdel").click( function(){
		if( _originalConfirm("<?php echo $this->language->get("message_delete");?>") ){
			var id = $(this).attr("rel").replace("id_","");
			window.location.href="<?php echo str_replace("&amp;","&",$actionDel);?>&id="+id;
		}
	} );
	$(document).ajaxSend(function() {
		$("#ajaxloading").show();
	});
	$(document).ajaxComplete(function() {
		$("#ajaxloading").hide();
	});
</script>
 <div class="modal fade" id="dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
        </div>
        <div class="modal-body">
         <iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
        </div>
        <div class="modal-footer">
	    <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
	    <a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript">

function image_upload(field, thumb) {

	$('#dialog').attr('data-field', field);
	$('#dialog').attr('data-thumb', thumb);
	$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

$(document.body).on('show.bs.modal', '#dialog', function () {
	$(this).find('#dialog-confirm').addClass('hide');
});

$(document.body).on('hidden.bs.modal', '#dialog', function () {
	var field = $(this).attr('data-field');
	var thumb = $(this).attr('data-thumb');

	if ($('#' + field).attr('value')) {
		$.ajax({
			url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
			dataType: 'text',
			success: function(data) {
				$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
			}
		});
	}
	$('#dialog').attr('data-field', '');
	$('#dialog').attr('data-thumb', '');
	$('#dialog #fm-iframe').attr('src', '');
});
</script>
<?php echo $footer; ?>