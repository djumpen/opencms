<?php echo $header; ?>
<div id="content">

    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>

    <div class="box" style="margin-bottom:130px;">
        <div class="heading">
            <h1><?php echo $lang_page_title; ?></h1>
            <div class="buttons">
                <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $lang_cancel; ?></span></a>
            </div>
        </div>
        <div class="content">
            <h3><?php echo $lang_created; echo $pricing['created']; ?></h3>
            <table class="list">
                <thead>
                <tr>
                    <td class="left"><?php echo $lang_column_name; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_product_id; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_product_type; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_dispatchto; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_price_uk; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_price_cheap_uk; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_price_euro; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_price_cheap_euro; ?></td>
                    <td class="center" width="75"><?php echo $lang_column_stock; ?></td>
                </tr>
                </thead>
                <tbody>
                <?php if ($pricing) { ?>
                <?php foreach ($pricing['products'] as $price) { ?>
                    <tr>
                        <td class="left"><?php echo $price['item-name']; ?></td>
                        <td class="center" width="75"><?php echo $price['product-id']; ?></td>
                        <td class="center" width="75"><?php echo $product_id_types[$price['product-id-type']]; ?></td>
                        <td class="center" width="75"><?php echo $product_dispatch_to[$price['dispatch-to']]; ?></td>
                        <td class="center" width="75">&pound;<?php echo number_format((double)$price['delivered-price-gbp'], 2); ?></td>
                        <td class="center" width="75">&pound;<?php echo number_format((double)$price['cheapest-delivered-price-gbp'], 2); ?></td>
                        <td class="center" width="75"><?php echo number_format((double)$price['delivered-price-euro'], 2); ?>&euro;</td>
                        <td class="center" width="75"><?php echo number_format((double)$price['cheapest-delivered-price-euro'], 2); ?>&euro;</td>
                        <td class="center" width="75"><?php echo $price['quantity']; ?></td>
                    </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                    <td class="center" colspan="9"><?php echo $lang_no_data_found; ?></td>
                </tr>
                <?php } ?>
                </tbody>
            </table>

            <div class="pagination"><?php 
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

<script type="text/javascript">
    $(document).ready(function() {

    });
    //--></script>
<?php echo $footer; ?>