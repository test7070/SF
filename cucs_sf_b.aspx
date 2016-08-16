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
				
				var p_title=window.parent.document.title;
                
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#chkSel_'+j).click(function() {
                		t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						var t_noa=$('#txtNoa_'+b_seq).val();
						var t_noq=$('#txtNoq_'+b_seq).val();
                		var t_picname=$('#txtPicname_'+b_seq).val();
                		var t_mins=dec($('#txtMins_'+b_seq).val()); //裁剪
                		var t_hours=dec($('#txtHours_'+b_seq).val()); //續接
                		var t_paraf=$('#txtParaf_'+b_seq).val();
                		var t_parag=$('#txtParag_'+b_seq).val();
                		
                		if(p_title.indexOf('裁剪')>-1 && $('#chkSel_'+b_seq).prop('checked')){
                			//判斷是否已續接或成型
                			var t_where = "where=^^ 1=1 and a.noa='"+t_noa+"' and b.noq='"+t_noq+"'^^";
							var t_where1 = "where[1]=^^ d.productno2=b.noa and d.product2=b.noq and c.itype!='1' and (d.mount>0 or d.weight>0) ^^";
							q_gt('cucs_sf', t_where+t_where1, 0, 0, 0,'getcubs', r_accy,1);
							var as = _q_appendData("view_cuc", "", true);
							if (as[0] != undefined){
								if(as[0].cubmount>0 || as[0].cubweight>0){
									var t_err='';
									if(t_paraf!='' && t_parag!='')
										t_err='續接';
									if(t_picname!='直料' && t_picname!='板料' &&t_picname!='')
										t_err=t_err+(t_err.length>0?'或':'')+'成型';
									
									if(!confirm('此加工品項已進行'+t_err+'生產，是否繼續?')){
	                					$('#chkSel_'+b_seq).prop('checked',false);
	                				}
								}
                			}else{
                				alert('加工單遺失，請確認加工單是否正確!!')
                			}
                		}
                		
                		if(p_title.indexOf('續接')>-1 && $('#chkSel_'+b_seq).prop('checked')){
                			if(t_mins!=1){
                				if(!confirm('此加工品項尚未進行裁剪，是否繼續?')){
                					$('#chkSel_'+b_seq).prop('checked',false);
                				}
                			}
                			//是否已成型判斷
                			if($('#chkSel_'+b_seq).prop('checked') && t_picname!='直料' && t_picname!='板料' &&t_picname!=''){
                				var t_where = "where=^^ 1=1 and a.noa='"+t_noa+"' and b.noq='"+t_noq+"'^^";
								var t_where1 = "where[1]=^^ d.productno2=b.noa and d.product2=b.noq and c.itype='3' and (d.mount>0 or d.weight>0) ^^";
								q_gt('cucs_sf', t_where+t_where1, 0, 0, 0,'getcubs', r_accy,1);
								var as = _q_appendData("view_cuc", "", true);
                				if (as[0] != undefined){
									if(as[0].cubmount>0 || as[0].cubweight>0){
										if(!confirm('此加工品項已進行成型生產，是否繼續?')){
		                					$('#chkSel_'+b_seq).prop('checked',false);
		                				}
									}
								}
                			}
                		}
                		
                		if(p_title.indexOf('成型')>-1 && $('#chkSel_'+b_seq).prop('checked')){
                			var t_err='';
                			if(t_mins!=1){ //未裁剪
                				t_err='裁剪';
                			}
                			if(t_paraf!='' || t_parag!=''){ //需續接
                				if(t_hours!=1){ //未續接
                					t_err=t_err+(t_err.length>0?'和':'')+'續接';
                				}
                			}
                			
                			if(t_err.length>0){
                				if(!confirm('此加工品項尚未進行'+t_err+'，是否繼續?')){
	                				$('#chkSel_'+b_seq).prop('checked',false);
	                			}
                			}
                		}
					});
                }
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
						<input id="txtMins.*" type="hidden" />
						<input id="txtHours.*" type="hidden" />
						<input id="txtParaf.*" type="hidden" />
						<input id="txtParag.*" type="hidden" />
					</td>
					<td style="width:12%;"><input class="txt" id="txtSize2.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>