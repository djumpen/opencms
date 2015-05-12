

<?php echo $header; ?>
<div id="content" class="container">
    <?php if ($error_install) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_install; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_image) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_image; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_image_cache) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_image_cache; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_cache) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_cache; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>

  <?php if ($error_logs) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_logs; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if (!empty($this->session->data['clear_cache'])) { $this->session->data['clear_cache'] = false; ?>
  <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $text_clear_cache; ?><button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-eye"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">

      <div class="row">

		<?php if ($this->config->get('google_api_code') != null && $this->config->get('google_profile_id') != null) { ?>
		<div class="col-xs-6">
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="label label-info"><?php echo $text_week; ?></span>
					<div style="width:100%;" data-oochart='bar' data-oochart-start-date='7d' data-oochart-metrics='ga:visits,Visits,ga:newVisits,New Visits' data-oochart-dimension='ga:continent' data-oochart-profile='<?php echo $this->config->get('google_profile_id'); ?>'></div>
				</div>
			</div>
		</div>
		<div class="col-xs-6">
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="label label-primary"><?php echo $text_month; ?></span>
					<div style="width:100%;" data-oochart='timeline' data-oochart-start-date='30d' data-oochart-metrics='ga:visits,Visits,ga:newVisits,New Visits' data-oochart-profile='<?php echo $this->config->get('google_profile_id'); ?>'></div>
				</div>
			</div>
		</div>	
		<?php } ?>

      </div>
      <br />
<!--calendar-->
<div id='loading' style='display:none'><i class="fa fa-spinner fa-spin"></i> loading...</div>
<div id='calendar'></div>
<br />
<!--calendar-->
      <ul class="nav nav-tabs">
        <li><a href="#tab-sale" data-toggle="tab"><?php echo $text_statistics; ?></a></li>
        <li class="active"><a href="#tab-latest" data-toggle="tab"><?php echo $text_latest_10_orders; ?></a></li>
        <li></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane" id="tab-sale">
          <div class="text-right">
            <div class="btn-group btn-group-xs" data-toggle="buttons">
              <label class="btn btn-info active">
                <input type="radio" name="sale" value="day" />
                <?php echo $text_day; ?></label>
              <label class="btn btn-info">
                <input type="radio" name="sale" value="week" />
                <?php echo $text_week; ?></label>
              <label class="btn btn-info">
                <input type="radio" name="sale" value="month" />
                <?php echo $text_month; ?></label>
              <label class="btn btn-info">
                <input type="radio" name="sale" value="year" />
                <?php echo $text_year; ?></label>
            </div>
          </div>
          <div id="chart-sale" class="chart" style="width: 100%; height: 250px;"></div>
        </div>

        <div class="tab-pane active" id="tab-latest">
         <div class="table-responsive">

		</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.min.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.resize.min.js"></script> 
<script type="text/javascript"><!--
$('input[name=\'sale\']').on('change', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/home/chart&token=<?php echo $token; ?>&range=' + this.value,
		dataType: 'json',
		success: function(json) {
			var option = {	
				shadowSize: 0,
				bars: { 
					show: true,
					fill: true,
					lineWidth: 1,
					barColor: '#000000'
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true
				},
				points: {
					show: false				
				},
				xaxis: {
					show: true,
            		ticks: json['xaxis']
				}
			}
			
			$.plot('#chart-sale', [json['order'], json['customer']], option);	
					
			$('#chart-sale').bind('plothover', function(event, pos, item) {
				$('.tooltip').remove();
			  
				if (item) {
					$('<div id="tooltip" class="tooltip top in"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + item.datapoint[1].toFixed(2) + '</div></div>').prependTo('body');
					
					$('#tooltip').css({
						position: 'absolute',
						left: item.pageX - ($('#tooltip').outerWidth() / 2),
						top: item.pageY - $('#tooltip').outerHeight(),
						pointer: 'cusror'
					}).fadeIn('slow');	
					
					$('#chart-sale').css('cursor', 'pointer');		
			  	} else {
					$('#chart-sale').css('cursor', 'auto');
				}
			});
		}
	});
});

$('a[data-toggle=\'tab\']').on('shown.bs.tab', function(e) {
	if ($(this).attr('href') == '#tab-sale') {
		$('.active input[name=\'sale\']').trigger('change');
	}
		
	if ($(this).attr('href') == '#tab-marketing') {
		$('.active input[name=\'marketing\']').trigger('change');
	}
	
	if ($(this).attr('href') == '#tab-online') {
		$('#button-refresh').trigger('click');
	}	
});
//--></script> 
<?php echo $footer; ?>