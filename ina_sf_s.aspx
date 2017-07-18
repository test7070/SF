<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var q_name = "ina_s";
            
            aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtStoreno', 'btnStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
			);

            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();

                $('#txtBdate').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_tggno = $('#txtTggno').val();
                t_comp = $('#txtComp').val();
                t_storeno = $('#txtStoreno').val();
                t_store = $('#txtStore').val();
                t_ordeno = $('#txtOrdeno').val();

                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
                /// 100.  .
                t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
                /// 100.  .

                var t_where = " 1=1 " 
	                + q_sqlPara2("noa", t_noa) 
	                + q_sqlPara2("datea", t_bdate, t_edate) 
	                + q_sqlPara2("tggno", t_tggno) 
	                + q_sqlPara2("storeno", t_storeno)
	                + q_sqlPara2("ordeno", t_ordeno)
                ;

                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%; ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblOrdeno'>合約號碼</a></td>
					<td><input class="txt" id="txtOrdeno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblTggno'> </a></td>
					<td>
						<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />&nbsp;
						<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" disabled="disabled" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblStoreno'> </a></td>
					<td>
						<input class="txt" id="txtStoreno" type="text" style="width:90px; font-size:medium;" />&nbsp;
						<input class="txt" id="txtStore" type="text" style="width:115px;font-size:medium;" disabled="disabled"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
