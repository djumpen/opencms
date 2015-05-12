<?php  echo $header;  ?>
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
		<div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="container">
                    <h1 class="panel-title pull-left"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
                    <div class="button-group pull-right">
                        <a onclick="__submit('delete')" class="btn btn-danger action-delete"><?php echo $this->language->get("button_delete"); ?></a>
                        <a onclick="__submit('published')" class="btn btn-success"><?php echo $this->language->get("button_publish"); ?></a>
                        <a onclick="__submit('unpublished')" class="btn  btn-warning"><?php echo $this->language->get("button_unpublish"); ?></a>
                    </div>
                </div>
            </div>
        </div>
			<div class="panel-body">
				<div class="box-columns">
					<form id="filter" method="post" action="<?php echo $action;?>">
						 <div class="filter-wrap row">
							<div class="filter-title  col-xs-4"><label><?php echo $this->language->get('text_filter_title');?></label>
								<input class="form-control" name="filter[title]" value="<?php echo $filter['title'];?>" size="50">
							</div>
							  
							<div class="filter-category col-xs-4 ">
							<label><?php echo $this->language->get('text_category');?></label>
							<?php echo $menus;?>
							</div>
							<div class=" col-xs-4">
							    <label style="display:block;">&nbsp;</label>
    							<button type="submit" name="submit" class="btn btn-default"><?php echo $this->language->get('text_filter');?></button>
    							<a href="<?php echo $action_reset;?>" class="btn btn-danger"><?php echo $this->language->get('text_reset');?></a>
							</div>
						 </div>
					 </form>
					<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action;?>">
						
				
						<input type="hidden" name="do-action" value="" id="do-action">
						<table  class="table table-striped table-bordered">
							<thead>
								<tr>
									<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></td>
									<td class="left"><?php echo $this->language->get("entry_title");?></td>
									<td class="center" width="200"><?php echo $this->language->get('text_position');?> <a onclick="__submit('position')" class="button"><?php echo $this->language->get("save"); ?></a></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_status');?></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_created');?></td>
									<td class="right"  width="60"><?php echo $this->language->get('text_hits');?></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_edit');?></td>
								</tr>
							</thead>
							
							<tbody>
								<?php foreach( $blogs as $blog ) {  // echo '<pre>'.print_r( $blog, 1 ); die;?>
								<tr>
									<td width="1" style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $blog['blog_id'];?>"></td>
									<td class="left"><?php echo $blog['title'];?></td>
									<td class="center"  ><input class="form-control" name="position[<?php echo $blog['blog_id'];?>]" value="<?php echo $blog['position'];?>" size="3"></td>
									<td class="right"><?php echo ($blog['status']?$this->language->get('text_enable'):$this->language->get('text_disable'));?></td>
									<td class="right"><?php echo $blog['created'];?></td>
									<td class="right"><?php echo $blog['hits'];?></td>
									<td class="right"><a href="<?php echo sprintf($edit_link, $blog['blog_id']) ?>" class="btn btn-primary"><?php echo $this->language->get('text_edit');?></a></td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
					</form>
				      <div class="row">
        <div class="col-xs-6 text-left"><?php 
if ($pagination){
$str = $pagination;

$str1 = str_replace('<div class="links">', '<ul class="pagination">', $str);
$str2 = str_replace('</div>', '</ul>', $str1);
$str3 = str_replace('<a', '<li><a', $str2);
$str4 = str_replace('</a>', '</a></li>', $str3);
$str5 = str_replace('<b>', '<li class="active"><a>', $str4);
$str6 = str_replace('</b>', '<span class="sr-only">(current)</span></a></li>', $str5);
$str7 = str_replace('&gt;|', '<i class="fa fa-angle-double-right"></i>', $str6);
$str8 = str_replace('&gt;', '<i class="fa fa-angle-right"></i>', $str7);
$str9 = str_replace('|&lt;', '<i class="fa fa-angle-double-left"></i>', $str8);
$str10 = str_replace('&lt;', '<i class="fa fa-angle-left"></i>', $str9);
$str11 = str_replace('....', '<li class="disabled"><span>....</span></li>', $str10);
echo $str11; 
}
?></div>
      </div>
				</div>
			</div>
		</div>	
		
		
 </div>
 
 <script type="text/javascript">
	$(".action-delete").click( function(){ return confirm('<?php echo $this->language->get('text_confirm_delete');?>') } );
	function __submit( val ){
		$("#do-action").val( val );
		$("#form").submit();
	}
	
	 
 </script>
<?php echo $footer; ?>