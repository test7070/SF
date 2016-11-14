<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "ina";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
	            ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
	            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            var abbsModi = [];

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                bbmNum = [['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]]
				bbsNum = [['txtLengthb', 10, 2, 1], ['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 10, q_getPara('rc2.weightPrecision'), 1]];
				
				q_gt('ucc', "1=1", 0, 0, 0, "bbsucc");
				q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
                q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
				
				$('#lblOrdeno_sf').click(function() {
					var t_where1="1=0^^";//cont
					var t_where2="where[1]=^^tggno='"+$('#txtTggno').val()+"' and f4>0 and isnull(enda,0)=0 ^^";//ordhs
					var t_where3="where[2]=^^1=0^^";//quat
					var t_where4="where[3]=^^1=0 order by datea,noa ^^";//ordbht
					
					q_box("cont_sf_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where1+t_where2+t_where3+t_where4, 'ordh_b', "600px", "700px", '互換合約');					
				});
				
				$('#txtOrdeno').change(function() {
					if(!emp($('#txtOrdeno').val())){
						var t_where="where=^^noa='"+$('#txtOrdeno').val()+"'^^ ";
						q_gt('ordh', t_where, 0, 0, 0, "hno_chage", r_accy);
					}
				});
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                	case 'ordh_b':
                		if(q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0 || b_ret[0]==undefined)
								return;
							$('#txtOrdeno').val(b_ret[0].noa);
						}
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			
			var ordh_weight=0;
			var t_ordhno='#non';
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'hno_chage':
                		var as = _q_appendData("ordh", "", true);
						if (as[0] != undefined) {
							if((as[0].enda)=="true"){
								alert($('#txtOrdeno').val()+'合約已結案!');
							}else if(dec(as[0].f4)<=0){
								alert($('#txtOrdeno').val()+'合約已入庫完畢!');
							}else if(!emp($('#txtTggno').val()) && $('#txtTggno').val()!=as[0].tggno){
								alert('合約廠商與入庫廠商不同!!');
							}
						}else{
							alert($('#txtOrdeno').val()+'合約不存在!!!');
						}
                		break;
                	case 'ordh_btnOk':
						var as = _q_appendData("ordh", "", true);
						if (as[0] != undefined) {
							ordh_weight=dec(as[i].f2);
							if(as[i].tggno!=$('#txtTggno').val()){
								alert('合約廠商與入庫廠商不同!!');
							}else{
								var t_where = "where=^^ ordeno='"+$('#txtOrdeno').val()+"' ^^"; //and noa!='"+$('#txtNoa').val()+"'
								q_gt('view_ina', t_where, 0, 0, 0, "ordh_view_ina", r_accy);	
							}
						}else{
							alert($('#txtOrdeno').val()+'合約號碼不存在!!');
						}
						break;
					case 'ordh_view_ina':
						var as = _q_appendData("view_ina", "", true);
						for ( i = 0; i < as.length; i++) {
							if(as[i].noa!=$('#txtNoa').val()){
								ordh_weight=q_sub(ordh_weight,dec(as[i].weight));
							}else{
								t_ordhno=as[i].ordeno;
							}
						}
						if(ordh_weight>=dec($('#txtWeight').val())){
							check_ordh=true;
							btnOk();
						}else{
							var t_err='合約號碼【'+$('#txtOrdeno').val()+'】合約剩餘重量'+FormatNumber(ordh_weight)+'小於入庫重量'+FormatNumber($('#txtWeight').val());
							alert(t_err);
						}
						ordh_weight=0;
						break;
					case 'checkInano_btnOk':
						var as = _q_appendData("view_rc2", "", true);
                        if (as[0] != undefined) {
                            alert('入庫單號已存在!!!');
                        } else {
                            wrServer($('#txtNoa').val());
                        }
						break;
					case'uccb':
                        var as = _q_appendData("uccb", "", true);
                        if (as[0] != undefined) {
                            alert("批號已存在!!");
                            $('#txtUno_' + b_seq).val('');
                        }
                        break;
					case 'bbsucc':
						var as = _q_appendData("ucc", "", true);
						var t_ucc='@';
						for ( i = 0; i < as.length; i++) {
							t_ucc+=","+as[i].product;
						}
						q_cmbParse("combProduct", t_ucc,'s');
						break;
                	case 'bbsspec':
						var as = _q_appendData("spec", "", true);
						var t_spec='@';
						for ( i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
						}
						q_cmbParse("combSpec", t_spec,'s');
						break;
					case 'bbscolor':
						var as = _q_appendData("color", "", true);
						var t_color='@';
						for ( i = 0; i < as.length; i++) {
							t_color+=","+as[i].color;
						}
						q_cmbParse("combUcolor", t_color,'s');
						break;
					case 'bbsclass':
						var as = _q_appendData("class", "", true);
						var t_class='@';
						for ( i = 0; i < as.length; i++) {
							t_class+=","+as[i].noa;
						}
						q_cmbParse("combClass", t_class,'s');
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
			
			var check_ordh=false;
			var check_uno=false,check_uno_count=0,check_uno_err='';
            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(!check_ordh && !emp($('#txtOrdeno').val())){
					var t_where = "where=^^ noa='"+$('#txtOrdeno').val()+"'^^";
					q_gt('ordh', t_where, 0, 0, 0, "ordh_btnOk", r_accy);
					return;
				}
				
				//檢查批號重覆
				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = i + 1; j < q_bbsCount; j++) {
						if ($.trim($('#txtUno_' + i).val()).length > 0 && $.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())) {
							alert('【' + $.trim($('#txtUno_' + i).val()) + '】批號重覆。\n' + (i + 1) + ', ' + (j + 1));
							return;
						}
					}
				}
				
				//判斷批號是否已存在
				if(!check_uno){
					check_uno_count=0;check_uno_err='';
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtUno_'+i).val())){
							q_func('qtxt.query.inacheckuno_'+i, 'cuc_sf.txt,getuno,'+$('#txtUno_'+i).val()+';'+$('#txtNoa').val());
							check_uno_count++;
						}	
					}
					if(check_uno_count>0){
						return;
					}else{
						check_uno=true;
					}
				}
				
				//取得UNO
				var needuno=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if(emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('費')==-1){
						needuno=true;
					}
				}
				if(!getnewuno && needuno){
					q_func('qtxt.query.getnewuno', 'cuc_sf.txt,getnewuno,ina;'+$('#txtNoa').val()+';'+q_getPara('sys.key_ina')+';'+$('#txtDatea').val());
					return;
				}
				
				getnewuno=false;
                check_uno=false;
                check_ordh=false;
                
                if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
                
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ina') + $('#txtDatea').val(), '/', ''));
                else {
					if (q_cur == 1){
						t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    	q_gt('view_ina', t_where, 0, 0, 0, "checkInano_btnOk", r_accy);
					}else{		
						wrServer(s1);
					}
				}
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ina_sf_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        //判斷是否重複或已存過入庫----------------------------------------
                        $('#txtUno_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            //判斷是否重複
                            for (var k = 0; k < q_bbsCount; k++) {
                                if (k != b_seq && $('#txtUno_' + b_seq).val() == $('#txtUno_' + k).val() && !emp($('#txtUno_' + k).val())) {
                                    alert("批號重複輸入!!");
                                    $('#txtUno_' + b_seq).val('');
                                }
                            }
                            //判斷是否已存過入庫
                            var t_where = "where=^^ noa='" + $('#txtUno_' + b_seq).val() + "' ^^";
                            q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
                        });
                        //-----------------------------------------------------------------
                        $('#combProduct_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
						});
						
                    	$('#combUcolor_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtPaytype_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
						});
						
						$('#combSpec_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtSpec_'+b_seq).val($('#combSpec_'+b_seq).find("option:selected").text());
						});
						
						$('#combClass_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtClass_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").text());
						});
						
						$('#txtSize_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
                        	bbsweight(b_seq);
						});
						
						$('#txtLengthb_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbsweight(b_seq);
						});
						
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbsweight(b_seq);
						});
                    }
                }
                _bbsAssign();
            }
            
            function bbsweight(n) {
            	var t_siez=replaceAll($('#txtSize_'+n).val(),'#','');
            	var t_weight=0;
            	switch(t_siez){
            		case '3': t_weight=0.560; break;
            		case '4': t_weight=0.994; break;
            		case '5': t_weight=1.560; break;
            		case '6': t_weight=2.250; break;
            		case '7': t_weight=3.040; break;
            		case '8': t_weight=3.980; break;
            		case '9': t_weight=5.080; break;
            		case '10': t_weight=6.390; break;
            		case '11': t_weight=7.900; break;
            		case '12': t_weight=9.570; break;
            		case '14': t_weight=11.40; break;
            		case '16': t_weight=15.50; break;
            		case '18': t_weight=20.20; break;
            	}
            	
            	var t_lengthb=dec($('#txtLengthb_'+n).val());
            	var t_mount=dec($('#txtMount_'+n).val());
            	
            	$('#txtWeight_'+n).val(round(q_mul(q_mul(t_weight,t_lengthb),t_mount),0));
            }

            function btnIns() {
                _btnIns();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
            	t_ordhno=$('#txtOrdeno').val();
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();

            }

            function btnPrint() {
                //q_box('z_inap_sf.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
            function q_stPost() {
				t_ordhno=t_ordhno.length==0?'#non':t_ordhno;
				if(q_cur==3){
					if(t_ordhno != '#non'){
						q_func('qtxt.query.changeordhsgweight', 'ordh.txt,changeordhs_sf,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_ordhno));
					}
					t_ordhno='#non';
				}
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				
				if((!emp($('#txtOrdeno').val()) || t_ordhno != '#non')){
					q_func('qtxt.query.changeordhsgweight', 'ordh.txt,changeordhs_sf,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_ordhno));
				}
				t_ordhno='#non';
			}

            function bbsSave(as) {
                if (!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];
                
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j

            }

            function refresh(recno) {
                _refresh(recno);

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#combProduct_'+i).attr('disabled', 'disabled');
                		$('#combUcolor_'+i).attr('disabled', 'disabled');
                		$('#combSpec_'+i).attr('disabled', 'disabled');
                		$('#combClass_'+i).attr('disabled', 'disabled');
                	}
                }else{
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#combProduct_'+i).removeAttr('disabled');
                		$('#combUcolor_'+i).removeAttr('disabled');
                		$('#combSpec_'+i).removeAttr('disabled');
                		$('#combClass_'+i).removeAttr('disabled');
                	}
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
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
            	t_ordhno=$('#txtOrdeno').val();
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
                t_ordhno='#non';
            }
			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.getnewuno':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_uno=as[0].uno;
							var t_noa=as[0].noa;
							var whilenum=0;
							if(t_noa!='' && ($('#txtNoa').val().length==0 || $('#txtNoa').val()=='AUTO'))
								$('#txtNoa').val(t_noa);
							if(t_uno!=''){
								//檢查是否與表身重覆
								while(1==1 && whilenum<q_bbsCount*q_bbsCount) //避免無窮迴圈
								{
									var isnoexists=true,needuno=false;
									for (var i = 0; i < q_bbsCount; i++) {
										if(!emp($('#txtUno_'+i).val())){
											if(t_uno==$('#txtUno_'+i).val()){
												isnoexists=false;
											}
										}
										if(emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('費')==-1){
											needuno=true;
										}
									}
									if(!needuno){
										break;
									}
									if(isnoexists){
										for (var i = 0; i < q_bbsCount; i++) {
											if(emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('費')==-1){
												$('#txtUno_'+i).val(t_uno);
												break;
											}
										}
									}
									t_uno=t_noa+'-'+('000'+(dec(t_uno.slice(-3))+1).toString()).slice(-3);
									whilenum++;
								}
							}
						}
						//不管有沒有批號都會存檔
						getnewuno=true;
	                	btnOk();
						break;
					case 'changeordhsgweight':
						break;
				}
				if(t_func.indexOf('qtxt.query.rc2suno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		alert("批號【"+as[0].uno+"】已存在!!");
                		$('#btnMinus_'+n).click();
                	}
				}
				if(t_func.indexOf('qtxt.query.inacheckuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		check_uno_err=check_uno_err+'批號【'+as[0].uno+'】已被領用\n';
                	}
                	
                	check_uno_count--;
                	if(check_uno_count==0){
	                	if(check_uno_err.length>0){
	                		alert(check_uno_err);
	                	}else{
	                		check_uno=true;
	                		btnOk();
	                	}
                	}
				}
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
                margin: -1px;
                border: 1px black solid;
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
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.num {
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:1%"><a id='vewChk'> </a></td>
					<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
					<td align="center" style="width:35%"><a id='vewTgg'> </a></td>
					<td align="center" style="width:35%"><a id='vewOrdeno_sf'>合約號碼</a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
					<td align="center" id='datea'>~datea</td>
					<td align="center" id='comp,8'>~comp,8</td>
					<td align="center" id='ordeno'>~ordeno</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr style="height: 1px;">
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td><input id="txtDatea" type="text" class="txt c3"/></td>
					<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
					<td><input id="txtNoa" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
					<td colspan="3">
						<input id="txtTggno" type="text"  class="txt c2"/>
						<input id="txtComp" type="text"  class="txt c3"/>
					</td>
				</tr>
				<tr>
					<td><span> </span><a id="lblStore" class="lbl btn" > </a></td>
					<td colspan="3">
						<input id="txtStoreno"  type="text"  class="txt c2"/>
						<input id="txtStore"  type="text" class="txt c3"/>
					</td>
				</tr>
				<tr>
					<td><span> </span><a id="lblOrdeno_sf" class="lbl btn">合約號碼</a></td>
					<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
					<td><span> </span><a id="lblWeight_sf" class="lbl">合約重量</a></td>
					<td><input id="txtWeight" type="text" class="txt num c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
					<td><input id="txtWorker" type="text" class="txt c1"/></td>
					<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
					<td><input id="txtWorker2" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblMemo_sf" class="lbl">備註</a></td>
					<td colspan='3'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
				</tr>
			</table>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:35px;">項序</td>
					<td style="width:120px; text-align: center;"><a id="lblUno_st" > </a></td>
					<td style="width:120px; text-align: center;">品名</td>
					<td style="width:150px; text-align: center;">類別</td>
					<td style="width:110px; text-align: center;">材質</td>
					<td style="width:75px; text-align: center;">號數</td>
					<td style="width:75px; text-align: center;">米數</td>
					<td style="width:90px; text-align: center;">廠牌</td>
					<td style="width:70px; text-align: center;">數量</td>
					<td style="width:80px; text-align: center;">重量kg</td>
					<td style=" text-align: center;">單項備註</td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input  id="txtUno.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1" style="width: 90px;"/>
						<select id="combProduct.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtUcolor.*" type="text" class="txt c1" style="width: 120px;"/>
						<select id="combUcolor.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtSpec.*" type="text" class="txt c1" style="width: 83px;"/>
						<select id="combSpec.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtSize.*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtClass.*" type="text" class="txt c1" style="width: 60px;"/>
						<select id="combClass.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>