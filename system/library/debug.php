<?php 
class Debug
{
    private static $_log = array();
    public static $_profs = array();

    public static function log($str, $dump = false, array $params = array())
    {
        if(is_array($str)) {
            $str = print_r($str, true);
        }
        $value = strtr($str, $params);
        if($dump) {
            ob_start();
            var_dump($value);
            $value = ob_get_clean();
        }
        self::$_log[] = '<pre>' . htmlspecialchars($value, ENT_QUOTES, 'UTF-8') . '</pre>';
    }

    public static function add($text, $top = 0)
    {
        $top ? array_unshift(self::$_log, $text) : self::$_log[] = $text;
    }

    public static function add_top($text)
    {
        self::add($text, true);
    }


    public static function show($sysstart)
    {
        global $db, $request, $session;
        require_once(DIR_SYSTEM . 'helper/geshi/geshi.php');
        
        if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && 'xmlhttprequest' == strtolower($_SERVER['HTTP_X_REQUESTED_WITH']))
            return;
        // подсчет времени генерации страницы
        self::add_top(round(( microtime(true) - $sysstart), 5). ' s');

        //расчет использованной памяти
        if (defined('MEM_USAGE')) {

            $mem_usage = ( memory_get_usage() - MEM_USAGE );
            $mem_usage = round($mem_usage / 1048576 * 100) / 100 . ' ' . 'mb';
        } else {
            $mem_usage = 'Недоступно';
        }
        self::add_top($mem_usage);

        
        $f = '';
        
        /* log */
        $log = self::$_log;
        $f .= '<div id="ptb_data_cont_custom" class="ptb_data_cont" style="display: none;">
                  <ul class="ptb_tabs">
                    <li id="ptb_tab_custom_default">logs messages <span>(' . count($log) . ')</span></li>
                  </ul>
                  <div id="ptb_tab_cont_custom_default" class="ptb_tab_cont">
                    <table class="ptb_tab_cont_table">
                      <tbody>
                        <tr>
                          <th style="width:20px;">№</th>
                          <th>message</th>
                        </tr>';
        $c = 1;
        foreach ($log as $value) {
            $f .= '<tr><td>' . $c . '</td><td> ' . $value . '</td></tr>';
            $c++;
        }
        unset($c);
        $f .= '<tr class="total">
                        <th></th>
                        <th>total ' . count(self::$_log) . ' messages</th>
                      </tr>
                      </tbody>
                    </table>
                  </div>
                </div>';

        /* подключенные файлы */
        $files = get_included_files();
        $f .= '<div id="ptb_data_cont_files" class="ptb_data_cont" style="display: none;">
                  <ul class="ptb_tabs">
                    <li id="ptb_tab_files">files <span>(' . count($files) . ')</span></li>
                  </ul>
                  <div id="ptb_tab_cont_files" class="ptb_tab_cont">
                    <table class="ptb_tab_cont_table">
                      <tbody>
                        <tr>
                          <th style="width:20px;">№</th>
                          <th>file</th>
                        </tr>';
        $c = 1;
        foreach ($files as $value) {
            $f .= '<tr><td>' . $c . '</td><td> ' . $value . '</td></tr>';
            $c++;
        }
        unset($c);
        $f .= '<tr class="total">
                        <th></th>
                        <th>total ' . count($files) . ' files</th>
                      </tr>
                      </tbody>
                    </table>
                  </div>
                </div>';
        
        /* Запросы в БД*/
        //$profs = $db->query("show profiles;"); 
        $profs = self::$_profs; 
//         $total_time = 0;
       
//         $p ='';
//         if (isset($profs)) {
//             foreach ($profs as $k=>$prof) {
//                 $style = ($prof['Duration'] > 0.009) ? 'style="background:#9B0404; color: #fff"' : '';
                
//                 $geshi = new GeSHi($prof['Query'], 'sql');
//                 $geshi->enable_classes();
//                 $geshi->enable_keyword_links(false);
//                 $res = $geshi->parse_code();
//                 $res = str_replace('<pre class="sql">','',$res);
//                 $res = str_replace('</pre>','',$res);
//                 $res = trim(rtrim($res),"\n");
                
//                 $p .= '<tr valign="top"><td '.$style.'>' . ($k + 1) . ' </td><td '.$style.'><pre class="source sql">' . $res .'</pre><span style="color: #4a4a4a;">'.$prof['file']. ' ('.$prof['line'].')</span></td><td class="tRight" '.$style.'> ' . $prof['Duration'] . ' s</td></tr>';
//                 $total_time += $prof['Duration'];
//             }
//         }
        
//         $f .= '
//         <div id="ptb_data_cont_sql" class="ptb_data_cont">
//             <ul class="ptb_tabs">
//               <li id="ptb_tab_sqldefault">profiles sql <span>(' . count($profs) . ')</span></li>
//             </ul>
//             <div id="ptb_tab_cont_sqldefault" class="ptb_tab_cont">
//             <table class="ptb_tab_cont_table">
//                 <tbody>
//                 <tr>
//                   <th style="width:20px;">№</th>
//                   <th>last 100 query</th>
//                   <th style="width:100px;">time</th>
//                 </tr>';
//         $f .= $p;
//         $f .= '<tr class="total">
//                     <td></td>
//                     <td>total ' . count($profs) . ' queries</td>
//                     <td class="tRight">' . $total_time . ' s</td>
//                   </tr>
//                   </tbody>
//                 </table>
//                 </div>
//             </div>';
        
        /* Request */
        $f .= '<div id="ptb_data_cont_request" class="ptb_data_cont" style="display: none;">
                  <ul class="ptb_tabs">
                    <li id="ptb_tab_request_default">Request <span>(' . count($log) . ')</span></li>
                  </ul>
                  <div id="ptb_tab_cont_request_default" class="ptb_tab_cont">';
        
        foreach ($request as $key=>$row) {
            $f .= '<table class="ptb_tab_cont_table">
                      <tbody>
                        <tr>
                          <th style="width:20px;"></th>
                          <th style="width:170px;"></th>
                          <th>'.$key.'</th>
                        </tr>';
                        $c = 1;
                        if($row){
                            foreach ($row as $k=>$r) {
                            	if(is_array($r)) {
                            		$f .= '<tr valign="top"><td>' . $c . ' </td><td> ' . $k . ' </td><td> ' . print_r($r, true) . '</td></tr>';
                            	} else {
                                	$f .= '<tr valign="top"><td>' . $c . ' </td><td> ' . $k . ' </td><td> ' . $r . '</td></tr>';
                            	}
                                $c++;
                            }
                        }else{
                            $f .= '<tr valign="top"><td>-</td><td>-</td><td>empty</td></tr>';
                        }
                        unset($c);
                        
             $f .= '</tbody>
                    </table>';
        }   
            //$_SESSION
             $f .= '<table class="ptb_tab_cont_table">
                      <tbody>
                        <tr>
                          <th style="width:20px;"></th>
                          <th style="width:170px;"></th>
                          <th>session</th>
                        </tr>';
             
             ob_start();
                print '<pre>';
                var_dump($session);
                print '</pre>';
             $s = ob_get_clean();
        
             $f .= '<tr valign="top"><td> </td><td>  </td><td>' . $s . ' </td></tr>';
             $f .= '</tbody>
                    </table>';
       
        $f .= '</div>
                </div>';
        if(isset($_COOKIE['dpc'])) {
        	$dpc_status = $_COOKIE['dpc'];
        } else {
        	$dpc_status = 'on';
        }
        if(isset($_COOKIE['dqc'])) {
        	$dqc_status = $_COOKIE['dqc'];
        } else {
        	$dqc_status = 'on';
        }
       
        // Начало вывода панели
        echo '<span style="display:none"><![CDATA[<noindex>]]></span>
        <!-- ============================= PROFILER TOOLBAR ============================= -->
        <script type="text/javascript" src="/admin/view/javascript/profilertoolbar.js"></script>
        <link rel="stylesheet" href="/admin/view/stylesheet/profilertoolbar.css">
        <div id="ptb">
            <ul id="ptb_toolbar" class="ptb_bg">
                <li class="cache" title="toggle page chaching (now ' . $dpc_status . ')" id="debugTogglePageCaching"><span class="icon"></span>Cache</li>
                <li class="queries sql" title="Toggle queries collecting (now ' . $dqc_status . ')" id="debugToggleQueriesCollecting"><span class="icon"></span>Queries</li>
                <li class="time" title="application execution time"><span class="icon"></span> ' . self::$_log[1] . '</li>
                <li class="ram" title="memory peak usage"><span class="icon"></span> ' . self::$_log[0] . ' </li>
                <li class="custom"><span class="icon"></span> logs <span class="total">(' . count($log) . ')</span></li>';
        if(!isset($_COOKIE['dqc']) || $_COOKIE['dqc'] == 'on') {
          	echo '<li class="sql"><span class="icon"></span> sql <span class="total">(' . count($profs) . ')</span></li>';
        }
          echo '<li class="files"><span class="icon"></span> files <span class="total">(' . count($files) . ')</span></li>
                <li class="request"><span class="icon"></span> request <span class="total">(' . count($files) . ')</span></li>
                <li class="hide" title="Hide Profiler Toolbar"><span class="icon"></span></li>
                <li class="show" title="Show Profiler Toolbar"><span class="icon"></span></li>
            </ul>
            <div id="ptb_data" class="ptb_bg" style="display: none;">
                ' . $f . '
            </div>
        </div>
        <!-- ============================= /PROFILER TOOLBAR ============================= -->
        <span style="display:none"><![CDATA[</noindex>]]></span>';
    }

}
