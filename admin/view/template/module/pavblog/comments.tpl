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
					
					 
					<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action ;?>">
					<input type="hidden" name="do-action" value="" id="do-action">
					<table  class="table table-striped table-bordered">
					  <thead>
						<tr>
						  <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></td>
						  <td class="left"><?php echo $this->language->get('text_comment');?></td>
						  
						  <td class="right"><?php echo $this->language->get('text_blog_title');?></td>
						
						  <td class="right" width="180"><?php echo $this->language->get('text_email');?></td>
						    <td class="right"  width="140"><?php echo $this->language->get('text_created');?></td>
						  <td class="right"  width="80"><?php echo $this->language->get('text_status');?></td>
						  <td class="right"  width="50">Action</td>
						</tr>
					  </thead>
					  <tbody>
						<?php foreach( $comments as $comment ) { ?>
						<tr>
						  <td width="1" style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $comment['comment_id'];?>"></td>
						  <td class="left"><?php echo $comment['comment'];?></td>
						  <td class="left"><a href="<?php echo $this->url->link('module/pavblog/blog','id='.$comment['blog_id'].'&token='.$token);?>"><?php echo $comment['title'];?></a></td>
						  <td class="right" ><?php echo $comment['email'];?></td>
						  <td class="right"><?php echo $comment['created'];?></td>
						  <td class="right" ><?php echo ($comment['status']?$this->language->get('text_enable'):$this->language->get('text_disable'));?></td>
						  <td class="right">
							<a href="<?php echo $this->url->link('module/pavblog/comment','id='.$comment['comment_id'].'&token='.$token);?>" class="btn btn-primary"><?php echo $this->language->get('text_edit');?></a>
						  </td>
						</tr>
						<?php } ?>
					  </tbody>
					</table>
					</form>
				 
				</div>
				
				
			</div>
		</div>	
		
		
 </div>
  
 <script type="text/javascript">
	$(".action-delete").click( function(){ return confirm('<?php echo $this->language->get('txt_confirm_delete');?>') } );
	function __submit( val ){
		$("#do-action").val( val );
		$("#form").submit();
	}
	
 </script>
<?php echo $footer; ?>