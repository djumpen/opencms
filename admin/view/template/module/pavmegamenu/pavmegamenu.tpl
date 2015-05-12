<?php

    echo $header; 
    if(isset($this->request->get['store_id'])) {
       $module_row = (int)$this->request->get['store_id'];
    } else {
	   $module_row = 0;
    }

?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
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
     <div class="pull-right">
        <button type="submit" form="form-category" class="btn btn-primary" onclick="$('#form').submit();"><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <button  class="btn btn-danger " onclick="location = '<?php echo $cancel; ?>';"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></button>
      </div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
      <div class="button-group">
           <button type="button" onclick="__submit('save-new')" class="btn btn-success"><?php echo $this->language->get('button_save_new'); ?></button> 
          <button type="button"  onclick="$('#form').submit();" class="btn btn-default"><?php echo $button_save; ?></button>
          <button type="button"  onclick="__submit('save-edit')" class="btn btn-default"><?php echo $this->language->get('button_save_edit'); ?></button>
<!--          <button type="button" href="<?php echo $liveedit_url; ?>" class="btn btn-success"><?php echo $this->language->get('text_live_edit'); ?></button>-->
          <button type="button"  href="<?php echo $cancel; ?>" class="btn btn-default"><?php echo $button_cancel; ?></button>
    </div>
    </div>
    <div class="panel-body">

    	     <ul class="nav nav-tabs">
    	     	<li class="active"><a href="#tab-manage-menus" data-toggle="tab"><?php echo $this->language->get('tab_manage_megamenus'); ?></a></li>
    	     <!--	<li><a href="#tab-manage-widgets" data-toggle="tab"><?php echo $this->language->get('tab_manage_widgets');?></a></li>-->
    	     </ul>
    	 <div class="tab-content">

	 		<div class="tab-pane active" id="tab-manage-menus">				
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                      <div><span style="font-weight:bold;"><?php echo $this->language->get('entry_filter_store');?></span>
                      		<ul class="nav nav-tabs">
							<?php foreach($stores as $store):?>
							<?php if($store['store_id'] == $store_id):?>
								<li class="active"><a  href="<?php echo $store['option'];?>" ><?php echo $store['name'];?></a></li>
							<?php else:?>
								<li><a href="<?php echo $store['option'];?>"><?php echo $store['name'];?></a></li>
							<?php endif;?>
							<?php endforeach;?>
							</ul>
						
						<input type="hidden" name="stores" value="<?php echo $store_id ?>"/>
						
						<input type="hidden" value="<?php echo $store_id;?>" name="megamenu[store_id]"/></br></br>
					</div>
					<div class="megamenu">
						<div class="col-xs-4">
							
							<h4><?php echo $this->language->get('text_treemenu');?></h4>
							<?php echo $tree; ?>
							
							<input type="button" name="serialize" id="serialize" value="Обновить" class="btn btn-success"/>
							<p></p>
							<p class="note"><i><?php echo $this->language->get("text_explain_drapanddrop");?></i></p>
						</div>
						<div class="col-xs-8">
							<h3><?php echo $this->language->get("text_menu_assignment");?></h3>
							<?php $i = 0; foreach ($modules as $module) { ?>
							
							<table <?php if($i != $module_row) { print 'style="display:none;"';} ?> class="table table-striped table-bordered table-hover">
							    <input type="hidden" name="pavmegamenu_module[<?php echo $i; ?>][module_id]" value="<?php print $i; ?>">
								<tr>
								  <td><?php echo $entry_layout; ?></td>
								  <td><select name="pavmegamenu_module[<?php echo $i; ?>][layout_id]" class="form-control">
									 <?php foreach ($layouts as $layout) { ?>
									  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
									  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
									  <?php } else { ?>
									  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
									  <?php } ?>
									  <?php } ?>
									</select></td>
								</tr>
								<tr>
								  <td><?php echo $entry_position; ?></td>
								  <td><select name="pavmegamenu_module[<?php echo $i; ?>][position]" class="form-control">
									  <?php foreach( $positions as $pos ) { ?>
									  <?php if ($module['position'] == $pos['pos']) { ?>
									  <option value="<?php echo $pos['pos'];?>" selected="selected"><?php echo $this->language->get('text_'.$pos['name']); ?></option>
									  <?php } else { ?>
									  <option value="<?php echo $pos['pos'];?>"><?php echo $this->language->get('text_'.$pos['name']); ?></option>
									  <?php } ?>
									  <?php } ?> 
									</select></td>
								</tr>
								<tr>
								  <td><?php echo $entry_status; ?></td>
								  <td><select name="pavmegamenu_module[<?php echo $i; ?>][status]" class="form-control">
									  <?php if ($module['status']) { ?>
									  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									  <option value="0"><?php echo $text_disabled; ?></option>
									  <?php } else { ?>
									  <option value="1"><?php echo $text_enabled; ?></option>
									  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									  <?php } ?>
									</select></td>
								</tr>
								<tr>
								  <td><?php echo $entry_sort_order; ?></td>
								  <td><input type="text" name="pavmegamenu_module[<?php echo $i; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3"  class="form-control"/></td>
								</tr>
							</table>
							<?php $i++; } ?>
							<div id="megamenu-form">
								<?php require( "pavmegamenu_form.tpl" );?>
							</div>
							</div>
						</div>
					</div>
					           <div  class="tab-pane" id="tab-manage-widgets">
                <p>
                    <i><?php echo $this->language->get('text_explain_widgets'); ?></i>
                </p>
                <div>
                    <a class="button btn btn-primary" href="index.php?route=module/pavmegamenu/addwidget&token=<?php echo $token; ?>" ><?php echo $this->language->get('text_create_widget'); ?></a>
                </div>
                <p></p>
                 <table  class="table table-striped table-bordered table-hover">
                    <tr>    
                        <td><?php echo $this->language->get('text_widget_name'); ?></td>
                        <td><?php echo $this->language->get('text_widget_type'); ?></td>
                        <td><?php echo $this->language->get('text_action'); ?></td>
                    </tr>
                    <?php if( is_array($widgets) ) { ?>
                    
                    <?php foreach( $widgets  as $widget ) { ?>
                    <tr>
                        <td><?php echo $widget['name']; ?></td>
                        <td><?php echo $this->language->get( 'text_widget_'.$widget['type'] ); ?></td>
                        <td><a class="btn btn-primary" rel="edit" href="index.php?route=module/pavmegamenu/addwidget&token=<?php echo $token; ?>&id=<?php echo $widget['id'];?>&wtype=<?php echo $widget['type'];?>"><?php echo $this->language->get('text_edit'); ?></a>
                            | 
                            <a class="btn btn-danger" onclick="return confirm('<?php echo $this->language->get('text_confirm_delete');?>, function(result){return result;}');"  rel="edit" href="index.php?route=module/pavmegamenu/delwidget&token=<?php echo $token; ?>&id=<?php echo $widget['id'];?>&wtype=<?php echo $widget['type'];?>"><?php echo $this->language->get('text_delete'); ?></a>
                        </td>
                    <?php } ?>
                    </tr>
                    <?php } ?>
                    
                 </table>
            </div>
					<input type="hidden" value="" name="save_mode" id="save_mode"/>
				 </form>
    	 	</div>
    	 </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

$('#grouptabs a').click( function(){
	$.cookie("megaactived_tab", $(this).attr("href") );
} );

if( $.cookie("megaactived_tab") !="undefined" ){
	$('#grouptabs a').each( function(){
		if( $(this).attr("href") ==  $.cookie("megaactived_tab") ){
			$(this).click();
			return ;
		}
	} );
	
}


$("#btn-guide").click( function(){
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="'+$(this).attr('href')+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Guide',
		close: function (event, ui) {},	
		bgiframe: false,
		width: 940,
		height: 500,
		resizable: false,
		modal: true
	});
	return false;
} );
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
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
	/*
	$(".quickedit").click( function(){
		
		var id = $(this).attr("rel").replace("id_","");
		$.post( "<?php echo str_replace("&amp;","&",$actionGetInfo);?>", {
			"id":id,	
			"rand":Math.random()},
			function(data){
				$("#megamenu-form").html( data );
			});
	} ); */
	$(".quickdel").click( function(){
		if(_originalConfirm("<?php echo $this->language->get("message_delete");?>")) {
		    var id = $(this).attr("rel").replace("id_","");
			window.location.href="<?php echo str_replace("&amp;","&",$actionDel);?>&id="+id+"&store_id=<?php print isset($this->request->get['store_id'])?$this->request->get['store_id']:0; ?>";
		}
	} );
	$(document).ajaxSend(function() {
		$("#ajaxloading").show();
	});
	$(document).ajaxComplete(function() {
		$("#ajaxloading").hide();
	});
</script>
<script type="text/javascript">
$("a.btn btn-primary").click( function(){  
	$('#dialog').remove();
	var _link = $(this).attr('href');
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="'+_link+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $this->language->get("text_add_widget"); ?>',
		close: function (event, ui) {
			location.reload();
		},	
		bgiframe: false,
		width: 980,
		height: 600,
		resizable: false,
		modal: true
	});
	return false;	
} );
</script>
<?php echo $footer; ?>
