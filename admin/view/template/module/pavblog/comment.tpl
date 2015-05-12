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
                        <a onclick="$('#form').submit();" class="btn btn-success"><?php echo $this->language->get("button_save"); ?></a>
                        <a onclick="__submit('save-edit')" class="btn btn-default"><?php echo $this->language->get('button_save_edit'); ?></a>
                        <a onclick="__submit('save-new')" class="btn btn-default"><?php echo $this->language->get('button_save_new'); ?></a>
                        <a  href="<?php echo $action_delete;?>" class="btn btn-danger action-delete"><?php echo $this->language->get("button_delete"); ?></a>

                    </div>
                </div>
            </div>
        </div>
            <div class="panel-body">
				<div class="box-columns">
					
					 
					<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action;?>">
							<input type="hidden" name="action_mode" id="action_mode" value=""/>
							<input type="hidden" name="pavblog_comment[comment_id]"  value="<?php echo $comment['comment_id'];?>"/>
							 <table  class="table table-striped table-bordered">
								<tr>
									<td><?php echo $this->language->get('entry_created');?></td>
									<td><?php echo $comment['created'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_user');?></td>
									<td><?php echo $comment['user'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_email');?></td>
									<td><?php echo $comment['email'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_status');?></td>
									<td>
										<select class="form-control" name="pavblog_comment[status]">
											<?php foreach( $yesno as $k=>$v ) { ?>
											<option value="<?php echo $k;?>"<?php if( $k==$comment['status']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
											<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_comment');?></td>
									<td><textarea class="form-control" rows="6" cols="90" name="pavblog_comment[comment]"><?php echo $comment['comment'];?></textarea></td>
								</tr>
							 </table>
					</form>
				 
				</div>
				
				
			</div>
		</div>	
		
		
 </div>
  
 <script type="text/javascript">
	$(".action-delete").click( function(){ 
		return confirm( "<?php echo $this->language->get("text_confirm_delete");?>" );
	} );
	function __submit( val ){
		$("#action_mode").val( val );
		$("#form").submit();
	}
	
 </script>
<?php echo $footer; ?>