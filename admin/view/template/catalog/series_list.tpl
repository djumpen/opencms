<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <li><a href="<?php print $this->url->link('common/home', 'token=' . $this->session->data['token']); ?>">Главная</a></li>
    <li><a href="<?php print $this->url->link('catalog/series', 'token=' . $this->session->data['token']); ?>">Серии продуктов</a></li>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right"></div>
      <h1 class="panel-title"><i class="fa fa-list"></i> Серии продуктов </h1>
    </div>
    <div class="panel-body">
      
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-center" style="width: 75%;">
                Название  
                </td>
                <td class="text-center">
                Действие  
                </td>
                
            </thead>
            <tbody>
            	<tr>
                    <td class="text-left">
              			<span>
              				<input class="form-control" type="text" value="" name="name" id="series_name" style="width: 100%;" autocomplete="off">
              			</span>
              		</td>  
                    <td class="text-right">
              			<span>
              				<a id="addSeries" class="btn btn-success" style="width: 100%;">
              					<i class="fa fa-plus"></i>
              					Создать
              				</a>
              			</span>
              			<script type="text/javascript">
							$(document).ready(function(){
								$('#addSeries').click(function(){
									var series_name = $('#series_name').val();
									$.ajax({
										url: '<?php print html_entity_decode($add_series_href); ?>',
										dataType: 'json',
										type: 'post',
										data: {name: series_name},
										beforeSend: function(){
											console.log('show preloader');
										},
										complete: function(){
											console.log('hide preloader');
										},
										success: function(response){
											if(response.error.length == 0) {
												if(response.message.length > 0) {
													$(response.message).each(function(){
														showSuccessMessage(this);
													});
												}
												setTimeout(function(){
													window.location.reload();
												}, 1500);
											} else {
												if(response.error.length > 0) {
													$(response.error).each(function(){
														showErrorMessage(this);
													});
												}
											}
										},
										error: function(e1,e2) {
											console.log(e1);
											console.log(e2);
										}
									});
								});
							});
              			</script>
              		</td>  
              	</tr>
            	<?php if(isset($series)) { ?>
            	<?php foreach ($series as $single) { ?>
                <tr series-id="<?php print $single['series_id']; ?>" class="series_record">
                    <td class="text-left">
              			<span>
              				<?php print $single['name']; ?>
              			</span>
              		</td>  
                    <td class="text-right">
              			<span>
              				<a href="<?php print $single['href']; ?>" class="btn btn-primary">
              					<i class="fa fa-edit"></i>
              					Список продуктов
              				</a>
              				<a href="<?php print $single['delete']; ?>" class="btn btn-danger removeSeries">
              					<i class="fa fa-trash-o"></i>
              					Удалить
              				</a>
              			</span>
              		</td>  
              	</tr>
              	<?php } ?>
              	<?php } ?>
            </tbody>
          </table>
        </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('.removeSeries').on('click', function(e){
		var url = $(this).attr('href');
		confirm('Вы уверены?', function(confirm){
			if(confirm) {
				$.ajax({
					url: url,
					dataType: 'json',
					type: 'post',
					beforeSend: function(){
						console.log('show preloader');
					},
					complete: function(){
						console.log('hide preloader');
					},
					success: function(response){
						if(response.error.length == 0) {
							if(response.message.length > 0) {
								$(response.message).each(function(){
									showSuccessMessage(this);
								});
							}
							setTimeout(function(){
								window.location.reload();
							}, 1500);
						} else {
							$(response.error).each(function(){
								showErrorMessage(this);
							});
						}
					},
					error: function(e1, e2){
						console.log(e1);
						console.log(e2);
					}
				});
			}
		});
		
		e.preventDefault();
		return false;
	});
});
</script>
<?php echo $footer; ?>