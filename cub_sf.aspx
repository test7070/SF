<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            q_tables = 't';
            var q_name = "cub";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtOrdeno', 'txtNo2','txtProductno2','txtProduct2'];
            var q_readonlyt = ['txtLengthc','txtGmount','txtGweight'];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 5;
            aPop = new Array(
            	['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
            	['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
            	['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
            	['txtStoreno__', 'btnStoreno__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
                q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function sum() {
                for (var j = 0; j < q_bbsCount; j++) {
                    var t_dime = dec($('#txtDime_' + j).val());
                    $('#txtBdime_' + j).val(round(q_mul(t_dime, 0.93), 2));
                    $('#txtEdime_' + j).val(round(q_mul(t_dime, 1.07), 2));
                }
            }

            function mainPost() {
            	bbsNum = [ ['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 9, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1], ['txtLengthc', 15, 2, 1]];//['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1],
            	bbtNum = [['txtGmount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtGweight', 9, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1], ['txtLengthc', 15, 2, 1]];
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
                q_mask(bbmMask);
                document.title='加工入庫/領料作業';
                
                q_cmbParse("combMechno2",'1@A剪,2@B剪,3@C剪,7@7辦公室,成型組,續接組');
                q_cmbParse("cmbItype",'1@裁剪,2@成型,3@續接');
                
                if(r_userno.toUpperCase()=='B01'){
					$('#combMechno2').val('1');
				}else if(r_userno.toUpperCase()=='B02'){
					$('#combMechno2').val('2');
				}else if(r_userno.toUpperCase()=='B03'){
					$('#combMechno2').val('3');
				}else{
					$('#combMechno2').val('7');
				}
                
                var t_where = "where=^^ 1=1 ^^";
				q_gt('ucc', t_where, 0, 0, 0, "");
                
                $('#btnCub_nouno').click(function() {
                	$('#textNouno').val('');
                	$('#div_nouno').show();
                	$('#textNouno').focus();
				});
				
				$('#textNouno').click(function() {
                	q_msg($(this),'多批號領料請用,隔開');
				});
				
				$('#btnOk_div_nouno').click(function() {
					var t_nouno=$.trim($('#textNouno').val());
					if(t_nouno.length>0){
						getunocount=0;
	                	getunoerr='';
						t_nouno=t_nouno.split(',');
						for (var i=0;i<t_nouno.length;i++){
							if(t_nouno[i].length>0){
								getunocount=getunocount+1;
								q_func('qtxt.query.cuctcheckuno_'+n, 'cuc_sf.txt,getuno,'+t_nouno[i]+';#non'+';#non'+';#non');
							}
						}
					}
				});
				
				$('#btnClose_div_nouno').click(function() {
					$('#textNouno').val('');
                	$('#div_nouno').hide();
				});
				
				$('#btnUnoprint').click(function() {
					if(!emp($('#txtNoa').val())){
						q_func( 'barvu.gen1', $('#txtNoa').val()+','+$('#txtMechno').val());
						//alert('暫不開放!!')
					}
				});
				
				$('#btnGettostore').click(function() {
					if(!emp($('#txtNoa').val())){
						if(confirm("確認要條碼領料轉庫存?")){
							q_func('qtxt.query.getcubdate', 'cuc_sf.txt,cubdate,' + encodeURI($('#txtNoa').val()));
						}
					}
				});
				
				$('#btnDeltostore').click(function() {
					if(!emp($('#txtNoa').val())){
						if(confirm("確認要條碼刪除轉庫存?")){
							q_func('qtxt.query.delcubdate', 'cuc_sf.txt,cubdate,' + encodeURI($('#txtNoa').val()));
						}
					}
				});
				
                $('#lblDatea').text('加工日');
                $('#lblBdate').text('排程日');
                $('#lblMechno2').text('人員組別');
                $('#lblMechno').text('機台');
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'ucc':
						var as = _q_appendData("ucc", "", true);
						var t_ucc='@';
						for ( i = 0; i < as.length; i++) {
							t_ucc+=","+as[i].product;
						}
						q_cmbParse("combProduct", t_ucc,'s');
						q_cmbParse("combProduct", t_ucc,'t');
						break;
                	case 'bbsspec':
						var as = _q_appendData("spec", "", true);
						var t_spec='@';
						for ( i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
						}
						q_cmbParse("combSpec", t_spec,'s');
						q_cmbParse("combSpec", t_spec,'t');
						break;
					case 'bbscolor':
						var as = _q_appendData("color", "", true);
						var t_color='@';
						for ( i = 0; i < as.length; i++) {
							t_color+=","+as[i].color;
						}
						q_cmbParse("combUcolor", t_color,'s');
						q_cmbParse("combUcolor", t_color,'t');
						break;
					case 'bbsclass':
						var as = _q_appendData("class", "", true);
						var t_class='@';
						for ( i = 0; i < as.length; i++) {
							t_class+=","+as[i].noa;
						}
						q_cmbParse("combClass", t_class,'s');
						q_cmbParse("combClass", t_class,'t');
						break;
                    case 'deleUccy':
                        var as = _q_appendData("uccy", "", true);
                        var err_str = '';
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if (dec(as[i].gweight) > 0) {
                                    err_str += as[i].uno + '已領料，不能刪除!!\n';
                                }
                            }
                            if (trim(err_str).length > 0) {
                                alert(err_str);
                                return;
                            } else {
                                _btnDele();
                            }
                        } else {
                            _btnDele();
                        }
                        break;
					case 'btnOk_cubs':
						var as = _q_appendData("view_cubs", "", true);
                        if (as[0] != undefined) {
                        	var t_uno='';
                        	for ( i = 0; i < as.length; i++) {
                        		t_uno=((t_uno.length>0)?',':'')+as[i].uno;
                        	}
                            alert(t_uno+"批號已存在!!");
                        }else{
                        	check_cubs_uno=true;
                        	btnOk();
                        }
                        break;
					case 'btnOk_getuno':
						var as = _q_appendData("view_cubs", "", true);
						var maxordeuno=[];
												
						for (var i=0;i<as.length;i++){
							maxordeuno.push({
								ordeno:as[i].uno.substr(0,15),
								noq:dec(as[i].uno.slice(-3))
							})
						}
						
						//判斷表身批號是否已被使用
						for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
							if(!emp($('#txtProduct_'+j).val()) && !emp($('#txtUno_'+j).val()) && !emp($('#txtOrdeno_'+j).val()) && !emp($('#txtNo2_'+j).val())){
								for (var i=0;i<maxordeuno.length;i++){
									if(maxordeuno[i].ordeno==$('#txtOrdeno_'+j).val()+$('#txtNo2_'+j).val()){
										maxordeuno[i].noq=$('#txtUno_'+j).val().slice(-3);
									}
								}	
							}
						}
						
						//寫入批號
						for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
							var maxnoq='',findorde=false; 
							if(!emp($('#txtProduct_'+j).val()) && emp($('#txtUno_'+j).val()) && !emp($('#txtOrdeno_'+j).val()) && !emp($('#txtNo2_'+j).val())){
								for (var i=0;i<maxordeuno.length;i++){
									if(maxordeuno[i].ordeno==$('#txtOrdeno_'+j).val()+$('#txtNo2_'+j).val()){
										findorde=true;
										maxnoq=('000'+(dec(maxordeuno[i].noq)+1)).slice(-3);
										$('#txtUno_'+j).val($('#txtOrdeno_'+j).val()+$('#txtNo2_'+j).val()+'-'+$('#txtMechno').val()+maxnoq);
										maxordeuno[i].noq=maxnoq;
									}
									if (findorde)
										break;
								}
								if(!findorde){
									$('#txtUno_'+j).val($('#txtOrdeno_'+j).val()+$('#txtNo2_'+j).val()+'-'+$('#txtMechno').val()+'001');
									maxordeuno.push({
										ordeno:$('#txtOrdeno_'+j).val()+$('#txtNo2_'+j).val(),
										noq:'001'
									})
								}
							}
						}
						
						get_maxuno=true;
						btnOk();
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            
            var nouno_noa=[];
            var getunocount=0,getunoerr='';
            function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.getcubdate':
						var as = _q_appendData("tmp0", "", true, true);
						var t_err='';
						for (var i=0; i<as.length; i++){
							if(as[0].mount !=as[0].bmount || as[0].weight !=as[0].bweight){
								t_err="加工單條碼已領料!!";
								break;
							}
							if(dec(as[0].vmount) >0 || dec(as[0].vweight) >0){
								t_err="加工單條碼已出貨!!";
								break;
							}
						}
						if(as.length==0){
							alert('加工單條碼不存在!!');
						}else if(t_err.length>0){
							alert(t_err);
						}else{
							//條碼領料轉庫存
							q_func('qtxt.query.gettostore', 'cuc_sf.txt,gettostore,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(r_userno)+ ';' + encodeURI(r_name));
						}
						break;
					case 'qtxt.query.gettostore':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_cubno=as[0].cubno;
							var t_scubno=as[0].scubno;
							q_func('cub_post.post.get1', r_accy + ',' + encodeURI(t_cubno) + ',1');
							q_func('cub_post.post.get2', r_accy + ',' + encodeURI(t_scubno) + ',1');
						}
						break;
					case 'cub_post.post.get2':
						alert("條碼領料轉庫存已完成!!");
						
						var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ 1=1 or 1=0 ^^"
						q_boxClose2(s2);
						break;
					case 'qtxt.query.delcubdate':
						var as = _q_appendData("tmp0", "", true, true);
						var t_err='';
						for (var i=0; i<as.length; i++){
							if(as[0].mount !=as[0].bmount || as[0].weight !=as[0].bweight){
								t_err="加工單條碼已領料!!";
								break;
							}
							if(dec(as[0].vmount) >0 || dec(as[0].vweight) >0){
								t_err="加工單條碼已出貨!!";
								break;
							}
						}
						if(as.length==0){
							alert('加工單條碼不存在!!');
						}else if(t_err.length>0){
							alert(t_err);
						}else{
							//條碼刪除轉庫存
							q_func('cub_post.post.del1', r_accy + ',' + encodeURI($('#txtNoa').val()) + ',0');
						}
						break;	
					case 'cub_post.post.del1':
						q_func('qtxt.query.deltostore', 'cuc_sf.txt,deltostore,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(r_userno)+ ';' + encodeURI(r_name));
						break;
					case 'qtxt.query.deltostore':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_cubno=as[0].cubno;
							q_func('cub_post.post.del2', r_accy + ',' + encodeURI(t_cubno) + ',1');
						}
						break;
					case 'cub_post.post.del2':
						alert("條碼刪除轉庫存已完成!!");
						
						var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ 1=1 or 1=0 ^^"
						q_boxClose2(s2);
						break;
					case 'qtxt.query.cubnouno':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_cubno=as[0].cubno;
							if(t_cubno!='')
								q_func('cub_post.post', r_accy + ',' + encodeURI(t_cubno) + ',1');
							else{
								alert("批號領料錯誤!!");
								Unlock();
							}
						}
						break;
					case 'cub_post.post':
						$('#div_nouno').hide();
						Unlock();
						alert("批號領料完成!!");
						
						var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ 1=1 or 1=0 ^^"
						q_boxClose2(s2);
						break;
				}
				if(t_func.indexOf('qtxt.query.cubsuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		alert("批號【"+as[0].uno+"】已存在!!");
                		$('#btnMinus_'+n).click();
                	}
				}
				if(t_func.indexOf('qtxt.query.cubtuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		if(dec(as[0].mount)<=0 || dec(as[0].weight)<=0 ){
                			alert("批號【"+as[0].uno+"】已被領用!!");
                			$('#btnMinut__'+n).click();
                		}else{
                			$('#btnMinut__'+n).click();
							q_gridAddRow(bbtHtm, 'tbbt', 'txtProduct,txtUcolor,txtSpec,txtSize,txtLengthb,txtClass,txtLengthc,txtGmount,txtGweight,txtUno,txtMemo'
								, as.length, as, 'product,ucolor,spec,size,lengthb,class,lengthc,mount,weight,uno,memo', 'txtUno');
							
							if(dec(n)+as.length>=q_bbtCount){
								$('#btnPlut').click();
							}
							$('#txtUno__'+q_add(dec(n),as.length)).focus().select();
                		}
                	}else{
                		alert("批號【"+$('#txtUno__'+n).val()+"】不存在!!");
                		$('#btnMinut__'+n).click();
                	}
				}
				if(t_func.indexOf('qtxt.query.cuctcheckuno_')>-1){
                	var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		if(dec(as[0].mount)<=0 || dec(as[0].weight)<=0 ){
                			getunoerr=getunoerr+'批號【'+as[0].uno+'】已被領用\n';
                		}
                	}
                	
                	getunocount=getunocount-1;
                	if(getunocount==0){ //批號檢查完畢
                		if(getunoerr.length>0){
                			alert(getunoerr);
                		}else{
                			var t_mechno=emp($('#combMechno').val())?'#non':$('#combMechno').val();
							var tt_nouno='';
							var t_nouno=$.trim($('#textNouno').val());
							t_nouno=t_nouno.split(',');
							for (var i=0;i<t_nouno.length;i++){
								if(t_nouno[i].length>0){
									tt_nouno=tt_nouno+t_nouno[i]+'#';
								}
							}
							if(tt_nouno.length>0){
								q_func('qtxt.query.cubnouno', 'cuc_sf.txt,cubnouno_sf,' + encodeURI(r_accy) + ';' + encodeURI(tt_nouno)+ ';' + encodeURI($('#combMechno2').val())+ ';' + encodeURI(r_userno)+ ';' + encodeURI(r_name)+';1');
								Lock();
							}
                		}
                	}
                }
			}

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'uccc':
                        if (!b_ret || b_ret.length == 0) {
                            b_pop = '';
                            return;
                        }
                        if (q_cur > 0 && q_cur < 4) {
                            for (var j = 0; j < b_ret.length; j++) {
                                for (var i = 0; i < q_bbtCount; i++) {
                                    var t_uno = $('#txtUno__' + i).val();
                                    if (b_ret[j] && b_ret[j].noa == t_uno) {
                                        b_ret.splice(j, 1);
                                    }
                                }
                            }
                            if (b_ret[0] != undefined) {
                                ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtUno,txtGmount,txtGweight,txtWidth,txtLengthb', b_ret.length, b_ret, 'uno,emount,eweight,width,lengthb', 'txtUno', '__');
                                /// 最後 aEmpField 不可以有【數字欄位】
                            }
                            sum();
                            b_ret = '';
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
				q_box('cub_sf_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                //$('#txtBdate').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                //q_box('z_cubp_sf.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
			
			var check_cubs_uno=false;
			var get_uno=false,get_maxuno=false;
            function btnOk() {
            	t_err = q_chkEmpField([['txtDatea', '加工日'],['txtMechno', q_getMsg('機台')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                
                //加工後 會多產品一個批號 不判斷批號是否重覆
               	//批號自己輸入
                sum();
                
                //105/12/08空白倉庫預設A
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProduct_'+i).val()) && emp($('#txtStoreno_'+i).val())){
						$('#txtStoreno_'+i).val('A');
						$('#txtStore_'+i).val('三泰-板料');
					}
				}
                
                if(q_cur==1){
                	$('#txtWorker').val(r_name);
                }else{
                	$('#txtWorker2').val(r_name);
                }
                
                //入庫日沒打預設今天
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtDate2_' + i).val()).length == 0)
						$('#txtDate2_' + i).val(q_date());
				}
                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function bbtSave(as) {
                if (!as['product'] && !as['uno']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#combUcolor_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtUcolor_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
						});
						$('#txtSize_' + i).change(function() {
							 if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
						});
                        
                        $('#btnUccc_' + i).click(function() {
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            var t_where = ' 1=1 and radius=0 ';
                            var t_productno = trim($('#txtProductno_' + n).val());
                            var t_bdime = dec($('#txtBdime_' + n).val());
                            var t_edime = dec($('#txtEdime_' + n).val());
                            var t_width = dec($('#txtWidth_' + n).val());
                            var t_blengthb = round(dec($('#txtLengthb_' + n).val()) * 0.88, 2);
                            var t_elengthb = round(dec($('#txtLengthb_' + n).val()) * 1.12, 2);

                            var t_array = {
                                productno : t_productno,
                                bdime : t_bdime,
                                edime : t_edime,
                                width : t_width,
                                blength : t_blengthb,
                                elength : t_elengthb
                            }

                            q_box("uccc_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;;" + encodeURIComponent(JSON.stringify(t_array)), 'uccc', "95%", "95%", q_getMsg('popUccc'));
                        });
                        
                        $('#combSpec_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtSpec_'+b_seq).val($('#combSpec_'+b_seq).find("option:selected").text());
						});
						
						$('#combClass_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtClass_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").text());
						});
						
						$('#combProduct_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
						});
						
						$('#txtUno_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_noa=$('#txtNoa').val();
							if(t_noa.length==0)
								t_noa='#non';
							if(!emp($('#txtUno_'+b_seq).val())){
								q_func('qtxt.query.cubsuno_'+b_seq, 'cuc_sf.txt,getuno,'+$('#txtUno_'+b_seq).val()+';'+t_noa+';#non'+';#non');
							}
						});
                    }
                }
                _bbsAssign();
                
                $('#lblCust_s').text('客戶');
                $('#lblProductno_s').text('品號');
                $('#lblProduct_s').text('品名');
                $('#lblUcolor_s').text('類別');
                $('#lblSpec_s').text('材質');
                $('#lblSize_s').text('號數');
                $('#lblLengthb_s').text('米數');
                $('#lblClass_s').text('廠牌');
                $('#lblUnit_s').text('單位');
                $('#lblLengthc_s').text('支數');
                $('#lblMount_s').text('件數');
                $('#lblWeight_s').text('重量');
                $('#lblPrice_s').text('單價');
                $('#lblUno_s').text('批號');
                $('#lblNeed_s').text('需求');
                $('#lblMemo_s').text('備註');
                $('#lblStore_s').text('入庫倉庫');
                $('#lblDate2_s').text('入庫日');
                $('#lblEnda_s').text('手結');
                $('#lblOrdeno_s').text('訂單編號');
                $('#lblNo2_s').text('訂序');
                $('#lblDatea_s').text('預定出貨日期');
                $('#lblHend_s').text('過磅結案');
                $('#lblProductno2_s').text('案號');
                $('#lblProduct2_s').text('案序');
            }

            function distinct(arr1) {
                var uniArray = [];
                for (var i = 0; i < arr1.length; i++) {
                    var val = arr1[i];
                    if ($.inArray(val, uniArray) === -1) {
                        uniArray.push(val);
                    }
                }
                return uniArray;
            }

            function getBBTWhere(objname) {
                var tempArray = new Array();
                for (var j = 0; j < q_bbtCount; j++) {
                    tempArray.push($('#txt' + objname + '__' + j).val());
                }
                var TmpStr = distinct(tempArray).sort();
                TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
                return TmpStr;
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#combUcolor__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtUcolor__'+b_seq).val($('#combUcolor__'+b_seq).find("option:selected").text());
						});
						$('#txtSize__' + i).change(function() {
							 if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
						});
						$('#combSpec__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtSpec__'+b_seq).val($('#combSpec__'+b_seq).find("option:selected").text());
						});
						
						$('#combClass__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtClass__'+b_seq).val($('#combClass__'+b_seq).find("option:selected").text());
						});
						
						$('#combProduct__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct__'+b_seq).val($('#combProduct__'+b_seq).find("option:selected").text());
						});
						
						$('#txtUno__'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_noa=$('#txtNoa').val();
							if(t_noa.length==0)
								t_noa='#non';
							if(!emp($('#txtUno__'+b_seq).val())){
								q_func('qtxt.query.cubtuno_'+b_seq, 'cuc_sf.txt,getuno,'+$('#txtUno__'+b_seq).val()+';'+t_noa+';#non'+';#non');
							}
						});
                    }
                }
                _bbtAssign();
                
                $('#lblUno_t').text('領料批號');
                $('#lblProductno_t').text('品號');
                $('#lblProduct_t').text('品名');
                $('#lblUcolor_t').text('類別');
                $('#lblSpec_t').text('材質');
                $('#lblSize_t').text('號數');
                $('#lblLengthb_t').text('米數');
                $('#lblClass_t').text('廠牌');
                $('#lblUnit_t').text('單位');
                $('#lblLengthc_t').text('領料支數');
                $('#lblGmount_t').text('領料件數');
                $('#lblGweight_t').text('領料重量');
                $('#lblMemo2_t').text('備註');
                $('#lblStore_t').text('領料倉');
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                var t_where = 'where=^^ uno in(' + getBBTWhere('Uno') + ') ^^';
                q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            function q_popPost(id) {
                switch (id) {
                    case 'txtProductno_':
                        $('#txtClass_' + b_seq).focus();
                        break;
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 75%;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: black;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 95%;
                float: left;
            }

            .num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] ,select{
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 100%;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<!--#include file="../inc/toolbar.inc"-->
		<div id="div_nouno" style="position:absolute; top:70px; left:840px; display:none; width:400px; background-color: #CDFFCE; border: 1px solid gray;">
			<table id="table_nouno" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 150px;" align="center">批號</td>
					<td style="background-color: #f8d463;width: 250px;"><input id="textNouno" type="text" class="txt c1"/></td>
				</tr>
				<tr id='nouno_close'>
					<td align="center" colspan='2'>
						<input id="btnOk_div_nouno" type="button" value="領料">
						<input id="btnClose_div_nouno" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><select id="cmbItype" class="txt c1"> </select> </td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<!--<td><input type="button" id="btnCub_nouno" value="條碼領料" style="width:120px;"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl"> </a></td>
						<td><input id="txtMechno" type="text" class="txt c1"/></td>
						<td><input id="txtMech" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMechno2" class="lbl"> </a></td>
						<td><select id="combMechno2" class="txt c1"> </select></td>
						<td><input type="button" id="btnUnoprint" value="條碼列印" style="width:120px;"/></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" style="width:45%;"/>
							<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
							<input id="txtEdate" type="text" style="width:45%;"/>
						</td>
					</tr>-->
					<!--<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
					<td><select id="cmbTypea" class="txt c1"> </select></td>-->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
						<!--<td><input type="button" id="btnGettostore" value="條碼領料轉庫存" style="width:130px;"/></td>
						<td><input type="button" id="btnDeltostore" value="條碼刪除轉庫存" style="width:130px;"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' style="min-width: 2400px;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;"> </td>
						<td style="width:100px;"><a id='lblCust_s'> </a></td>
						<!--<td style="width:150px;"><a id='lblProductno_s'> </a></td>-->
						<td style="width:150px;"><a id='lblProduct_s'> </a></td>
						<td style="width:150px;"><a id='lblUcolor_s'> </a></td>
						<td style="width:150px;"><a id='lblSpec_s'> </a></td>
						<td style="width:100px;"><a id='lblSize_s'> </a></td>
						<td style="width:100px;"><a id='lblLengthb_s'> </a></td>
						<td style="width:100px;"><a id='lblClass_s'> </a></td>
						<!--<td style="width:55px;"><a id='lblUnit_s'> </a></td>-->
						<td style="width:85px;"><a id='lblLengthc_s'> </a></td>
						<td style="width:85px;"><a id='lblMount_s'> </a></td>
						<td style="width:85px;"><a id='lblWeight_s'> </a></td>
						<!--<td style="width:100px;"><a id='lblPrice_s'> </a></td>-->
						<!--<td style="width:150px;"><a id='lblNeed_s'> </a></td>-->
						<td style="width:150px;"><a id='lblMemo_s'> </a></td>						
						<td style="width:100px;"><a id='lblDate2_s'> </a></td>
						<td style="width:200px;"><a id='lblStore_s'> </a></td>
						<!--<td style="width:30px;"><a id='lblEnda_s'> </a></td>-->
						<td style="width:150px;"><a id='lblOrdeno_s'> </a></td>
						<td style="width:60px;"><a id='lblNo2_s'> </a></td>
						<td style="width:100px;"><a id='lblDatea_s'> </a></td>
						<td style="width:200px;"><a id='lblUno_s'> </a></td>
						<td style="width:150px;"><a id='lblProductno2_s'> </a></td>
						<td style="width:60px;"><a id='lblProduct2_s'> </a></td>
						<!--<td style="width:45px;"><a id='lblHend_s'> </a></td>-->
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtCustno.*" type="text" class="txt c1" style="display:none;"/>
							<input id="txtComp.*" type="text" class="txt c1"/>
						</td>
						<!--<td>
							<input id="txtProductno.*" type="text" class="txt c1" style="width: 83%;"/>
							<input class="btn" id="btnProductno.*" type="button" value='.' style="font-weight: bold;" />
						</td>-->
						<td>
							<input id="txtProduct.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combProduct.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td>
							<input id="txtUcolor.*" type="text" class="txt c1" style="width: 110px;"/>
							<select id="combUcolor.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td>
							<input id="txtSpec.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combSpec.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td><input id="txtSize.*" type="text" class="txt c1" /></td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1" /></td>
						<td>
							<input id="txtClass.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combClass.*" class="txt" style="width: 20px;"> </select>
						</td>
						<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtLengthc.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
						<!--<td><input id="txtPrice.*" type="text" class="txt num c1"/></td>-->
						<!--<td><input id="txtNeed.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtStoreno.*" type="text" class="txt c1" style="width: 30%;"/>
							<input class="btn" id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
							<input id="txtStore.*" type="text" class="txt c1" style="width: 50%;"/>
						</td>
						<!--<td><input id="chkEnda.*" type="checkbox"/></td>-->
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
						<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
						<td><input id="txtUno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno2.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct2.*" type="text" class="txt c1"/></td>
						<!--<td><input id="chkHend.*" type="checkbox"/></td>-->
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="width: 1320px;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:180px;"><a id='lblUno_t'> </a></td>
					<!--<td style="width:150px;"><a id='lblProductno_t'> </a></td>-->
					<td style="width:150px;"><a id='lblProduct_t'> </a></td>
					<td style="width:150px;"><a id='lblUcolor_t'> </a></td>
					<td style="width:150px;"><a id='lblSpec_t'> </a></td>
					<td style="width:100px;"><a id='lblSize_t'> </a></td>
					<td style="width:100px;"><a id='lblLengthb_t'> </a></td>
					<td style="width:100px;"><a id='lblClass_t'> </a></td>
					<!--<td style="width:55px;"><a id='lblUnit_t'> </a></td>-->
					<td style="width:100px;"><a id='lblLengthc_t'> </a></td>
					<td style="width:100px;"><a id='lblGmount_t'> </a></td>
					<td style="width:100px;"><a id='lblGweight_t'> </a></td>
					<!--<td style="width:150px;"><a id='lblStore_t'> </a></td>-->
					<td style="width:150px; text-align: center;"><a id='lblMemo2_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<!--<td>
						<input id="txtProductno..*" type="text" class="txt c1" style="width: 83%;"/>
						<input class="btn" id="btnProductno..*" type="button" value='.' style="font-weight: bold;" />
					</td>-->
					<td>
						<input id="txtProduct..*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combProduct..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtUcolor..*" type="text" class="txt c1" style="width: 110px;"/>
						<select id="combUcolor..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtSpec..*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combSpec..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtSize..*" type="text" class="txt c1" /></td>
					<td><input id="txtLengthb..*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtClass..*" type="text" class="txt c1" style="width: 60%;"/>
						<select id="combClass..*" class="txt" style="width: 20px;"> </select>
					</td>
					<!--<td><input id="txtUnit..*" type="text" class="txt c1"/></td>-->
					<td><input id="txtLengthc..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGweight..*" type="text" class="txt c1 num"/></td>
					<!--<td>
						<input id="txtStoreno..*" type="text" class="txt c1" style="width: 30%"/>
						<input class="btn"  id="btnStoreno..*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtStore..*" type="text" class="txt c1" style="width: 50%"/>
					</td>-->
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>