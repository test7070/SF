<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'orde', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = 'orde_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            q_desc=1;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
                setTimeout('parent.$.fn.colorbox.resize({innerHeight : "520px"})', 300);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

			function mainPost(){
				
			}

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width:12%;"><a id='lblNoa_sf'>訂單號碼</a></td>
					<td align="center" style="width:10%;"><a id='lblOdate_sf'>預交日</a></td>
					<td align="center" style="width:10%;"><a id='lblDatea_sf'>訂單日期</a></td>
					<td align="center" style="width:20%;"><a id='lblCust_sf'>客戶</a></td>
					<td align="center" style="width:20%;"><a id='lblAddr2_sf'>工地名稱</a></td>
					<td align="center"><a id='lblMemo_sf'>備註</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input name="sel"  id="radSel.*" type="radio" /></td>
					<td><input class="txt" id="txtNoa.*" type="text" style="width:98%;" /></td>
					<td><input class="txt" id="txtOdate.*" type="text" style="width:98%;" /></td>
					<td><input class="txt" id="txtDatea.*" type="text" style="width:98%;" /></td>
					<td>
						<input class="txt" id="txtCustno.*" type="text" style="width:25%;" />
						<input class="txt" id="txtComp.*" type="text" style="width:70%;" />
					</td>
					<td><input class="txt" id="txtAddr2.*" type="text" style="width:98%;" /></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>