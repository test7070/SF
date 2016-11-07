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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 't';
            var q_name = "ordh";
            var q_readonly = ['txtWorker', 'txtWorker2','textF3','textF4','textF8','textF9'];         
            var q_readonlys = [];
            var q_readonlyt = [];
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
            brwKey = 'Datea';
            brwCount2 = 5;

            aPop = new Array(
	            ['txtTggno', 'lblTgg_sf', 'view_cust_tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'custtgg_b.aspx'],
	            ['txtCno', 'lblCno_sf', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
           	);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
			
			var t_tmp='';
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                bbmNum = [['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]
                		,['textF1', 15, q_getPara('vcc.weightPrecision'), 1],['textF2', 15, q_getPara('vcc.weightPrecision'), 1]
                		,['textF3', 15, q_getPara('vcc.weightPrecision'), 1],['textF4', 15, q_getPara('vcc.weightPrecision'), 1]
                		,['textF6', 15, q_getPara('vcc.weightPrecision'), 1],['textF7', 15, q_getPara('vcc.weightPrecision'), 1]
                		,['textF8', 15, q_getPara('vcc.weightPrecision'), 1],['textF9', 15, q_getPara('vcc.weightPrecision'), 1]
                		];
            					
            	bbsNum = [['txtLengthb', 10, 2, 1]
            			, ['txtMount', 10, q_getPara('vcc.mountPrecision'), 1]
            			, ['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1]
            			, ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1]
            			];
            	bbtNum = [['txtLengthb', 10, 2, 1]
            			, ['txtMount', 10, q_getPara('vcc.mountPrecision'), 1]
            			, ['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1]
            			, ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1]
            			];
                
                document.title = '互換/委外代工/來料加工 合約作業';
                q_cmbParse("cmbTypea", ',委外代工,來料,互換');
                
				q_gt('ucc', "1=1", 0, 0, 0, "bbsucc");
				q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
                q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
				
				$('#combAccount').change(function() {
					if(q_cur==1 || q_cur==2)
						$('#txtAddr').val($('#combAccount').find("option:selected").text());
				});
				
				$('#txtWeight').change(function() {
					
					var t_weight=dec($('#txtWeight').val());
                	var t_rate=dec($('#textF1').val())
                	if(t_rate==0){
                		$('#textF2').val(t_weight);
                	}else{
                		$('#textF2').val(round(t_weight-(t_weight*t_rate/100),q_getPara('vcc.weightPrecision')));
                	}
                	$('#textF2').change();
					
                	var t_rate=dec($('#textF6').val())
                	if(t_rate==0){
                		$('#textF7').val(t_weight);
                	}else{
                		$('#textF7').val(round(t_weight-(t_weight*t_rate/100),q_getPara('vcc.weightPrecision')));
                	}
                	$('#textF7').change();
                	
                	
				});
                
                $('#textF1').keyup(function(e) {
                	if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				}).change(function() {
                	$('#txtF1').val($(this).val());
                	
                	var t_weight=dec($('#txtWeight').val());
                	var t_rate=dec($('#textF1').val())
                	if(t_rate==0){
                		$('#textF2').val(t_weight);
                	}else{
                		$('#textF2').val(round(t_weight-(t_weight*t_rate/100),q_getPara('vcc.weightPrecision')));
                	}
                	$('#textF2').change();
				});
				
				$('#textF2').keyup(function(e) {
                	if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				}).change(function() {
                	$('#txtF2').val($(this).val());
                	
                	var t_tweight=dec($(this).val());
                	var t_endweight=dec($('#textF3').val())
                	$('#textF4').val(t_tweight-t_endweight);
                	$('#textF4').change();
				});
				
				$('#textF3').change(function() {
                	$('#txtF3').val($(this).val());
				});
				
                $('#textF4').change(function() {
                	$('#txtF4').val($(this).val());
				});
                
                $('#textMemo1').change(function() {
                	$('#txtMemo1').val($(this).val());
				});
                
                $('#textF6').keyup(function(e) {
                	if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				}).change(function() {
                	$('#txtF6').val($(this).val());
                	
                	var t_weight=dec($('#txtWeight').val());
                	var t_rate=dec($('#textF6').val())
                	if(t_rate==0){
                		$('#textF7').val(t_weight);
                	}else{
                		$('#textF7').val(round(t_weight-(t_weight*t_rate/100),q_getPara('vcc.weightPrecision')));
                	}
                	$('#textF7').change();
				});
				
				$('#textF7').keyup(function(e) {
                	if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				}).change(function() {
                	$('#txtF7').val($(this).val());
                	
                	var t_tweight=dec($(this).val());
                	var t_endweight=dec($('#textF8').val())
                	$('#textF9').val(t_tweight-t_endweight);
                	$('#textF9').change();
				});
				
				$('#textF8').change(function() {
                	$('#txtF8').val($(this).val());
				});
				
				$('#textF9').change(function() {
                	$('#txtF9').val($(this).val());
				});
				
				$('#textMemo2').change(function() {
                	$('#txtMemo2').val($(this).val());
				});
				
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'custms':
                		var as = _q_appendData("custms", "", true);
                		var t_account='@';
                		for ( i = 0; i < as.length; i++) {
                			if(as[i].account!='')
                				t_account+=","+as[i].account;
                		}
                		$('#combAccount').text('');
                		q_cmbParse("combAccount", t_account);
                		break;
                	case 'bbsucc':
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	
            	if($('#txtPrice_0').val())
					$('#txtF5').val($('#txtPrice_0').val());
				else
					$('#txtF5').val(0);
            	
            	if($('#txtPrice__0').val())
					$('#txtF10').val($('#txtPrice__0').val());
				else
					$('#txtF10').val(0);
            	
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('CO' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('ordh_sf_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    	$('#combProduct_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
						});
						
                    	$('#combUcolor_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtPaytype_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
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
								$('#txtBrand_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").text());
						});
						
						$('#txtIndate_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
                        	bbsweight(b_seq);
						});
						
						$('#txtLengthb_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbsweight(b_seq);
						});
						
						$('#txtMount_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbsweight(b_seq);
						});
                    	
                    }
                }
                _bbsAssign();
                refreshBbm();
            }
            
            function bbsweight(n) {
            	var t_siez=replaceAll($('#txtIndate_'+n).val(),'#','');
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

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                        $('#combProduct__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct__'+b_seq).val($('#combProduct__'+b_seq).find("option:selected").text());
						});
						
                    	$('#combUcolor__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtPaytype__'+b_seq).val($('#combUcolor__'+b_seq).find("option:selected").text());
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
								$('#txtBrand__'+b_seq).val($('#combClass__'+b_seq).find("option:selected").text());
						});
						
						$('#txtIndate__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
                        	bbtweight(b_seq);
						});
						
						$('#txtLengthb__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbtweight(b_seq);
						});
						
						$('#txtMount__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	bbtweight(b_seq);
						});
                    }
                }
                _bbtAssign();
            }
            
            function bbtweight(n) {
            	var t_siez=replaceAll($('#txtIndate__'+n).val(),'#','');
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
            	
            	var t_lengthb=dec($('#txtLengthb__'+n).val());
            	var t_mount=dec($('#txtMount__'+n).val());
            	
            	$('#txtWeight__'+n).val(round(q_mul(q_mul(t_weight,t_lengthb),t_mount),0));
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                refreshBbm();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                refreshBbm();
            }

            function btnPrint() {
                q_box("z_ordhp_sf.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='"+trim($('#txtNoa').val())+"';" + r_accy + "_" + r_cno, 'z_ordhp_sf', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
            function bbtSave(as) {
				if (!as['product']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

            function sum() {
                
            }

            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                }
                Unlock();
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                $('#vewDatea').text('訂約日期');
                $('#vewNoa').text('合約號碼');
                $('#vewNick').text('配合廠商');
                $('#vewTypea').text('類型');
                refreshBbm();
                if(!emp($('#txtTggno').val())){
					q_gt('custms', "where=^^noa='"+$('#txtTggno').val()+"'^^ ", 0, 0, 0, "custms");
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para){
                	
                	$('#combAccount').attr('disabled', 'disabled');
                	
                	$('#textF1').attr('disabled', 'disabled');
                	$('#textF2').attr('disabled', 'disabled');
                	$('#textMemo1').attr('disabled', 'disabled');
                	$('#textF6').attr('disabled', 'disabled');
                	$('#textF7').attr('disabled', 'disabled');
                	$('#textMemo2').attr('disabled', 'disabled');
                	
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#combProduct_'+i).attr('disabled', 'disabled');
                		$('#combUcolor_'+i).attr('disabled', 'disabled');
                		$('#combSpec_'+i).attr('disabled', 'disabled');
                		$('#combClass_'+i).attr('disabled', 'disabled');
                	}
                	for (var i = 0; i < q_bbtCount; i++) {
                		$('#combProduct__'+i).attr('disabled', 'disabled');
                		$('#combUcolor__'+i).attr('disabled', 'disabled');
                		$('#combSpec__'+i).attr('disabled', 'disabled');
                		$('#combClass__'+i).attr('disabled', 'disabled');
                	}
                }else{
                	
                	$('#combAccount').removeAttr('disabled');
                	
                	$('#textF1').removeAttr('disabled');
                	$('#textF2').removeAttr('disabled');
                	$('#textMemo1').removeAttr('disabled');
                	$('#textF6').removeAttr('disabled');
                	$('#textF7').removeAttr('disabled');
                	$('#textMemo2').removeAttr('disabled');
                	
                	for (var i = 0; i < q_bbsCount; i++) {
                		$('#combProduct_'+i).removeAttr('disabled');
                		$('#combUcolor_'+i).removeAttr('disabled');
                		$('#combSpec_'+i).removeAttr('disabled');
                		$('#combClass_'+i).removeAttr('disabled');
                	}
                	for (var i = 0; i < q_bbtCount; i++) {
                		$('#combProduct__'+i).removeAttr('disabled');
                		$('#combUcolor__'+i).removeAttr('disabled');
                		$('#combSpec__'+i).removeAttr('disabled');
                		$('#combClass__'+i).removeAttr('disabled');
                	}
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }

            function btnPlut(org_htm, dest_tag, afield) {
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
                if (q_chkClose())
                    return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function q_popPost(s1) {
			   	switch (s1) {
			   		case 'txtTggno':
			   			if(!emp($('#txtTggno').val())){
							q_gt('custms', "where=^^noa='"+$('#txtTggno').val()+"'^^ ", 0, 0, 0, "custms");
						}else{
							$('#combAccount').text('');
						}
			   			break;
			   	}
			}
			
			function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
                
                $('#textF1').val(FormatNumber($('#txtF1').val()));
                $('#textF2').val(FormatNumber($('#txtF2').val()));
                $('#textF3').val(FormatNumber($('#txtF3').val()));
                $('#textF4').val(FormatNumber($('#txtF4').val()));
                $('#textMemo1').val($('#txtMemo1').val());
                $('#textF6').val(FormatNumber($('#txtF6').val()));
                $('#textF7').val(FormatNumber($('#txtF7').val()));
                $('#textF8').val(FormatNumber($('#txtF8').val()));
                $('#textF9').val(FormatNumber($('#txtF9').val()));
                $('#textMemo2').val($('#txtMemo2').val());
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1240px;
            }
            .dview {
                float: left;
                width: 500px;
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
                width: 740px;
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
                width: 15%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
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
            }
            .dbbs {
                width: 1240px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            tr.sel td {
                background-color: yellow;
            }
            tr.chksel td {
                background-color: bisque;
            }
            #dbbt {
                width: 1240px;
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
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            
            #title_dbbs {
                width: 1240px;
            }
            #title_tbbs {
                margin: 0;
                padding: 2px;
                border: 2px #cad3ff double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            #title_tbbs tr td {
                text-align: center;
                border: 2px #ffffff double;
            }
            
            #title_dbbt {
                width: 1240px;
            }
            #title_tbbt {
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
            #title_tbbt tr td {
                text-align: center;
                border: 2px #ffffff double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' align="center">~datea</td>
						<td id='noa' style="text-align: left;" >~noa</td>
						<td id='nick' style="text-align: left;" >~nick</td>
						<td id='typea' style="text-align: left;" >~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
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
						<td><span> </span><a id="lblNoa_sf" class="lbl" >合約號碼</a></td>
						<td colspan="3"><input id="txtNoa"type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea_sf" class="lbl">訂約日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCno_sf" class="lbl btn" >簽約公司</a></td>
						<td><input id="txtCno"type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp"type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea_sf' class="lbl">合約類型</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg_sf" class="lbl btn" >配合廠商</a></td>
						<td><input id="txtTggno"type="text" class="txt c1"/></td>
						<td colspan="2">
							<input id="txtTgg"type="text" class="txt c1"/>
							<input id="txtNick"  type="text" class="txt" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_sf" class="lbl" >交貨工地</a></td>
						<td colspan="3">
							<input id="txtAddr"type="text" class="txt c1" style="width: 92%;"/>
							<select id="combAccount" class="txt" style="width: 20px;"> </select>
						</td>
						<td><span> </span><a id="lblWeight_sf" class="lbl" >合約重量</a></td>
						<td><input id="txtWeight"type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo_sf" class="lbl">報表備註</a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAtax_sf' class="lbl">含稅</a></td>
						<td colspan="2">
							<input id="chkAtax" type="checkbox"/>
							<span> </span><a id='lblTrans_sf' class="lbl" style="float: none;">含運</a>
							<input id="chkIstran" type="checkbox"/>
							<span> </span><a id='lblEnda_sf' class="lbl" style="float: none;">終止</a>
							<input id="chkEnda" type="checkbox"/>
							
							<input id="txtTrans" type="hidden"/>
						</td>
						<td>
							<input id="txtF1" type="hidden"><!--進貨損耗%-->
							<input id="txtF2" type="hidden"><!--進貨總量Kg-->
							<input id="txtF3" type="hidden"><!--進貨已完成-->
							<input id="txtF4" type="hidden"><!--進貨餘量-->
							<input id="txtF5" type="hidden"><!--進貨單價-->
							<input id="txtMemo1" type="hidden"><!--進貨備註-->
							<input id="txtF6" type="hidden"><!--出貨損耗%-->
							<input id="txtF7" type="hidden"><!--出貨總量Kg-->
							<input id="txtF8" type="hidden"><!--出貨已完成-->
							<input id="txtF9" type="hidden"><!--出貨餘量-->
							<input id="txtF10" type="hidden"><!--出貨單價-->
							<input id="txtMemo2" type="hidden"><!--出貨備註-->
						</td>
					</tr>
				</table>
			</div>
		</div>
		<HR style="width: 1240px;height: 2px;background: burlywood;margin: 3px;">
		<div id="title_dbbs">
			<table id="title_tbbs">
				<tr style="background: lightskyblue;">
					<td colspan="5" style="height: 35px;">進貨(KG)</td>
				</tr>
				<tr style="height: 25px;">
					<td style="width: 110px;">損耗%</td>
					<td style="width: 110px;">總量Kg</td>
					<td style="width: 110px;">已完成</td>
					<td style="width: 110px;">餘量</td>
					<td>備註</td>
				</tr>
				<tr style="height: 25px;">
					<td><input id="textF1" type="text" class="txt num c1"/></td>
					<td><input id="textF2" type="text" class="txt num c1"/></td>
					<td><input id="textF3" type="text" class="txt num c1"/></td>
					<td><input id="textF4" type="text" class="txt num c1"/></td>
					<td><input id="textMemo1" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center;background:#cad3ff;' >
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:35px;">項序</td>
					<td style="width:120px; text-align: center;">品名</td>
					<td style="width:150px; text-align: center;">類別</td>
					<td style="width:110px; text-align: center;">材質</td>
					<td style="width:75px; text-align: center;">號數</td>
					<td style="width:75px; text-align: center;">米數</td>
					<td style="width:90px; text-align: center;">廠牌</td>
					<td style="width:70px; text-align: center;">數量</td>
					<td style="width:80px; text-align: center;">重量kg</td>
					<td style="width:80px; text-align: center;">單價</td>
					<td style=" text-align: center;">單項備註</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1" style="width: 90px;"/>
						<select id="combProduct.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtPaytype.*" type="text" class="txt c1" style="width: 120px;"/>
						<select id="combUcolor.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtSpec.*" type="text" class="txt c1" style="width: 83px;"/>
						<select id="combSpec.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtIndate.*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtBrand.*" type="text" class="txt c1" style="width: 60px;"/>
						<select id="combClass.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<HR style="width: 1240px;height: 2px;background: burlywood;margin: 3px;">
		<div id="title_dbbt">
			<table id="title_tbbt" style=' text-align:center'>
				<tr style="background: lightcoral;">
					<td colspan="5" style="height: 35px;">出貨(KG)</td>
				</tr>
				<tr style="height: 25px;">
					<td style="width: 110px;">損耗%</td>
					<td style="width: 110px;">總量Kg</td>
					<td style="width: 110px;">已完成</td>
					<td style="width: 110px;">餘量</td>
					<td>備註</td>
				</tr>
				<tr style="height: 25px;">
					<td><input id="textF6" type="text" class="txt num c1"/></td>
					<td><input id="textF7" type="text" class="txt num c1"/></td>
					<td><input id="textF8" type="text" class="txt num c1"/></td>
					<td><input id="textF9" type="text" class="txt num c1"/></td>
					<td><input id="textMemo2" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<div id="dbbt">
			<table id="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:30px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="+"/></td>
					<td align="center" style="width:35px;">項序</td>
					<td style="width:120px; text-align: center;">品名</td>
					<td style="width:150px; text-align: center;">類別</td>
					<td style="width:110px; text-align: center;">材質</td>
					<td style="width:75px; text-align: center;">號數</td>
					<td style="width:75px; text-align: center;">米數</td>
					<td style="width:90px; text-align: center;">廠牌</td>
					<td style="width:70px; text-align: center;">數量</td>
					<td style="width:80px; text-align: center;">重量kg</td>
					<td style="width:80px; text-align: center;">單價</td>
					<td style="text-align: center;">單項備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="-"/>
						<input id="txtNoq..*" type="text" style="display:none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProduct..*" type="text" class="txt c1" style="width: 90px;"/>
						<select id="combProduct..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtPaytype..*" type="text" class="txt c1" style="width: 120px;"/>
						<select id="combUcolor..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtSpec..*" type="text" class="txt c1" style="width: 83px;"/>
						<select id="combSpec..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtIndate..*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthb..*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtBrand..*" type="text" class="txt c1" style="width: 60px;"/>
						<select id="combClass..*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtMount..*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight..*" type="text" class="txt num c1"/></td>
					<td><input id="txtPrice..*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
