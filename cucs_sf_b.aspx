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
            var q_name = 'view_cuc', t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'cucs_sf_load';
            t_postname = q_name;
            brwCount = -1;
            brwCount2 = 0;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            }

            function bbsAssign() {
                _bbsAssign();
				$('#lblPicname').text('加工型式');
				$('#lblSpec').text('材質');
				$('#lblSize').text('號數');
				$('#lblLengthb').text('長度(米)');
				$('#lblMount1').text('支數');
				$('#lblMount').text('件數');
				$('#lblWeight').text('重量(KG)');
				$('#lblMemo').text('備註 (標籤)');
				$('#lblSize2').text('內部工令');
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
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"> </td>
					<td align="center"><a id='lblPicname'> </a></td>
					<td align="center"><a id='lblSpec'> </a></td>
					<td align="center"><a id='lblSize'> </a></td>
					<td align="center"><a id='lblLengthb'> </a></td>
					<td align="center"><a id='lblMount1'> </a></td>
					<td align="center"><a id='lblMount'> </a></td>
					<td align="center"><a id='lblWeight'> </a></td>
					<td align="center"><a id='lblMemo'> </a></td>
					<td align="center"><a id='lblSize2'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:2%;">	<input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:12%;"><input class="txt" id="txtPicname.*" type="text" style="width:98%;" /></td>
					<td style="width:10%;"><input class="txt" id="txtSpec.*" type="text" style="width:98%;" /></td>
					<td style="width:8%;"><input class="txt" id="txtSize.*" type="text" style="width:98%;" /></td>
					<td style="width:8%;"><input class="txt" id="txtLengthb.*" type="text" style="width:98%;" /></td>
					<td style="width:10%;"><input class="txt" id="txtMount1.*" type="text" style="width:98%;text-align:right;" /></td>
					<td style="width:10%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;text-align:right;" /></td>
					<td style="width:10%;"><input class="txt" id="txtWeight.*" type="text" style="width:98%;text-align:right;" /></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
						<input id="recno.*" type="hidden" />
						<input id="txtNoa.*" type="hidden" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td style="width:12%;"><input class="txt" id="txtSize2.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>