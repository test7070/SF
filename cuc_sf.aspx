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
			q_desc=1;
            q_tables = 's';
            var q_name = "cuc";
            var q_readonly = ['txtWorker', 'txtWorker2','textWeight','txtCust']; //'txtNoa'
            var q_readonlys = ['txtPicname','txtMech','txtMech2'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 6;
            aPop = new Array(
            	['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx'],
            	['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
            	['txtMechno2_', 'btnMechno2_', 'mech', 'noa,mech', 'txtMechno2_,txtMech2_', 'mech_b.aspx'],
            	['txtPicno_', 'btnPicno_', 'img', 'noa,namea', 'txtPicno_,txtPicname_', 'img_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_bbsLen = 15;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
                q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
				q_gt('adpro', "where=^^1=1 and isnull(product,'')!='' ^^", 0, 0, 0, "bbsparafg");
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
            	document.title='料單整理作業';
            	bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtMount1', 10, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1]
            					,['txtWeight1', 15, 2, 1], ['txtWeight2', 15, 2, 1], ['txtWeight3', 15, 2, 1], ['txtWeight4', 15, 2, 1], ['txtWeight5', 15, 2, 1]
            					, ['txtParaa', 15, 0, 1], ['txtParab', 15, 0, 1], ['txtParac', 15, 0, 1], ['txtParad', 15, 0, 1], ['txtParae', 15, 0, 1]
            					];//['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1],
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd]];
                bbsMask = [];
                q_mask(bbmMask);
				//q_cmbParse("combProduct", q_getPara('vccs_vu.product'),'s');
				q_cmbParse("cmbBtime", ',棕,紅,白,黃,綠,灰,藍','s');
				q_cmbParse("cmbEtime", ',棕,紅,白,黃,綠,灰,藍','s');
				
				var t_where = "where=^^ 1=1 and unit='KG' ^^";
				q_gt('ucc', t_where, 0, 0, 0, "");
				
				$('#txtNoa').change(function() {
					$('#txtNoa').val(trim($('#txtNoa').val()));
                    if ($(this).val().length > 0) {
                        t_where = "where=^^ noa='" + $(this).val() + "'^^";
                        q_gt('view_cuc', t_where, 0, 0, 0, "checkCucno_change", r_accy);
                    }
                });
                
                $('#txtTypea').change(function() {
                	$('#txtTypea').val(trim($('#txtTypea').val()));
                    if ($(this).val().length > 0) {
                        var t_where1="where=^^noa='"+$(this).val()+"'^^";//cont
						var t_where2="where[1]=^^noa='"+$(this).val()+"'^^";//ordhs
						var t_where3="where[2]=^^noa='"+$(this).val()+"'^^";//quat
						var t_where4="where[3]=^^noa='"+$(this).val()+"' order by datea,noa ^^";//ordbht
                        q_gt('cont_sf', t_where1+t_where2+t_where3+t_where4, 0, 0, 0, "getcont", r_accy,1);
                        var as = _q_appendData("cont", "", true);
                        if (as[0] == undefined) {
                        	alert('合約號碼【'+$(this).val()+'】不存在!!!');
                        }
                    }
                	
                });
				
				$('#checkGen').click(function() {
					if(q_cur==1 || q_cur==2){
						if($('#checkGen').prop('checked'))
							$('#txtGen').val(1);
						else
							$('#txtGen').val(0);
					}
				});
				
				$('#txtCustno').change(function() {
					if(!emp($('#txtCustno').val())){
						q_gt('custms', "where=^^noa='"+$('#txtCustno').val()+"'^^ ", 0, 0, 0, "custms");
					}else{
						$('#combAccount').text('');
					}
				});
				
				$('#combAccount').change(function() {
					if(q_cur==1 || q_cur==2)
						$('#txtMech').val($('#combAccount').find("option:selected").text());
				});
				
				$('#btnOrde').click(function() {
					var t_where='1=1 and isnull(enda,0)!=1 and isnull(cancel,0)!=1 '
					if(!emp($('#txtCustno').val())){
						t_where=t_where+"and custno='"+$('#txtCustno').val()+"' ";
					}
					
					q_box("orde_sf_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'orde_sf', "95%", "95%", $('#btnOrde').val());
				});
				
				$('#btnImg').click(function() {
					if($(this).val()=='圖型顯示'){
						$(this).val('圖型關閉');
						$('.img').show();
					}else{
						$(this).val('圖型顯示');
						$('.img').hide();
					}
					bbswidth();
				});
				
				$('#btnPic').click(function() {
					if($(this).val()=='成型參數顯示'){
						$(this).val('成型參數關閉');
						$('.pic').show();
					}else{
						$(this).val('成型參數顯示');
						$('.pic').hide();
					}
					bbswidth();
				});
				
				$('#btnPic2').click(function() {
					if($(this).val()=='續接參數顯示'){
						$(this).val('續接參數關閉');
						$('.pic2').show();
					}else{
						$(this).val('續接參數顯示');
						$('.pic2').hide();
					}
					bbswidth();
				});
                
                $('#lblNoa').text('案號'); 
                $('#lblCust').text('客戶名稱');
                $('#lblMemo').text('備註');
                $('#lblDatea').text('日期'); 
                $('#lblGen').text('取消'); 
                $('#lblBdate').text('預訂交貨日');
                $('#lblMech').text('工地名稱');
                $('#lblWeight').text('料單總重量');
                $('#lblTypea').text('合約號碼');
            }
            
            function bbswidth() {
				var t_width=1900;
				if($('#btnImg').val()=='圖型關閉'){ //圖型顯示
					t_width=t_width+200;
				}
				if($('#btnPic').val()=='成型參數關閉'){ //成型參數顯示
					t_width=t_width+500;
				}
				if($('#btnPic2').val()=='續接參數關閉'){ //續接參數顯示
					t_width=t_width+220;
				}
				$('#tbbs').css("width",t_width+"px");
				$('.dbbs').css("width",t_width+"px");
			}
			
            function q_popPost(s1) {
                switch(s1) {
					case 'txtPicno_':
                		var n = b_seq;
                		t_noa = $('#txtPicno_'+n).val();
                		//console.log('popPost:'+t_noa);
                		q_gt('img', "where=^^noa='"+t_noa+"'^^", 0, 0, 0, JSON.stringify({action:"getimg",n:n}),1);
                	break;
                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                	case 'orde_sf':
                		if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							if(b_ret[0]!= undefined){
								$('#txtCustno').val(b_ret[0].custno);
								$('#txtCust').val(b_ret[0].nick);
								$('#txtMech').val(b_ret[0].addr2);
								$('#txtBdate').val(b_ret[0].datea);
								$('#txtMemo').val(b_ret[0].memo);
								
								if(b_ret[0].noa.length>0){
									q_gt('view_ordes', "where=^^ noa='" + b_ret[0].noa + "'^^", 0, 0, 0, "getordes", r_accy,1);
									var as = _q_appendData("view_ordes", "", true);
									
									for(var i = 0;i < as.length;i++){
										for (var j = 0; j < q_bbsCount; j++) {
											if(as[i].noa==$('#txtOrdeno_'+j).val() && as[i].no2==$('#txtNo2_'+j).val()){
												as.splice(i, 1);
												i--;
												break;
											}
										}
									}
									
									ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtProduct,txtUcolor,txtSpec,txtSize,txtLengthb,txtClass,txtMount,txtWeight,txtMemo'
									, as.length, as, 'noa,no2,product,ucolor,spec,size,lengthb,class,mount,weight,memo', 'txtProduct,txtOrdeno');
								}
							}
						}
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkCucno_change':
						var as = _q_appendData("view_cuc", "", true);
                        if (as[0] != undefined) {
                            alert('案號【'+as[0].noa+'】已存在!!!');
                        }
                        break;
                	case 'checkCucno_btnOk':
                		var as = _q_appendData("view_cuc", "", true);
                        if (as[0] != undefined) {
                            alert('案號【'+as[0].noa+'】已存在!!!');
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
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
                	case 'ucc':
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
					case 'bbsparafg':
						var as = _q_appendData("adpro", "", true);
						var t_product='@';
						for ( i = 0; i < as.length; i++) {
							t_product+=","+as[i].product;
						}
						q_cmbParse("combParaf", t_product,'s');
						q_cmbParse("combParag", t_product,'s');
						break;	
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
					default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="getimg"){
                    			var n = t_para.n;
                    			as = _q_appendData("img", "", true);
                    			if(as[0]!=undefined){
                    				$('#txtPara_'+n).val(as[0].para);
                    				$('#txtImgorg_'+n).val(as[0].org);
                    			}else{
                    				$('#txtPara_'+n).val('');
                    				$('#txtImgorg_'+n).val('');
                    			}
                    			createImg(n);
                    		}else if(t_para.action=="createimg" || t_para.action=="createimg_btnOk"){
                    			alert('錯誤!!');
							}
                    	}catch(e){
                    		Unlock(1);
                    	}
                        break;
                }
            }
            
            function createImg(n){
				var t_picno = $('#txtPicno_'+n).val();
				var t_para = $('#txtPara_'+n).val();
                var t_imgorg = $('#txtImgorg_'+n).val();
				try{
					t_para = JSON.parse(t_para);
				}catch(e){
					console.log('createImg:'+t_para);
				}
				if(t_imgorg.length==0)
					return;
				//$('#imgPic_'+n).attr('src',t_imgorg);
				var image = document.getElementById('imgPic_'+n);
				image.src=t_imgorg;
                var imgwidth = 300;
                var imgheight = 100;
                $('#canvas_'+n).width(imgwidth).height(imgheight);
                var c = document.getElementById("canvas_"+n);
				var ctx = c.getContext("2d");		
				c.width = imgwidth;
				c.height = imgheight;
				image.onload = function() {
					ctx.drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight);
					var t_length = 0;
					createImg2(n);
				}
			};
			
			function createImg2(n){
				var t_picno = $('#txtPicno_'+n).val();
				var t_para = $('#txtPara_'+n).val();
                var t_imgorg = $('#txtImgorg_'+n).val();
				try{
					t_para = JSON.parse(t_para);
				}catch(e){
					console.log('createImg:'+t_para);
				}
				if(t_imgorg.length==0)
					return;
				var image = document.getElementById('imgPic_'+n)
                var imgwidth = 300;
                var imgheight = 100;
                var c = document.getElementById("canvas_"+n);
				$('#imgPic_'+n).attr('src',c.toDataURL());
				image.onload = function() {
					//條碼用圖形
					xx_width = 355;
					xx_height = 119;						
					$('#canvas_'+n).width(xx_width).height(xx_height);
					c.width = xx_width;
					c.height = xx_height;
					$('#canvas_'+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,xx_width,xx_height);
					
					$('#txtImgbarcode_'+n).val(c.toDataURL());
					createImg3(n);
				}
			};
			
			function createImg3(n){
				var t_picno = $('#txtPicno_'+n).val();
				var t_para = $('#txtPara_'+n).val();
                var t_imgorg = $('#txtImgorg_'+n).val();
				try{
					t_para = JSON.parse(t_para);
				}catch(e){
					console.log('createImg:'+t_para);
				}
				if(t_imgorg.length==0)
					return;
				var image = document.getElementById('imgPic_'+n);
				image.src=t_imgorg;
                var imgwidth = 300;
                var imgheight = 100;
                $('#canvas_'+n).width(imgwidth).height(imgheight);
                var c = document.getElementById("canvas_"+n);
				var ctx = c.getContext("2d");		
				c.width = imgwidth;
				c.height = imgheight;
				image.onload = function() {
					ctx.drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight);
					var t_length = 0;
					//106/05/10 參數不劃入圖中
					for(var i=0;i<t_para.length;i++){
						value = $('#txtPara'+t_para[i].key.toLowerCase()+'_'+n).val();
						if(value!=0){
							t_length += value;
							ctx.font = t_para[i].fontsize+"px Arial";
							ctx.fillStyle = 'black';
							ctx.textAlign="center";
							ctx.fillText(value+'',t_para[i].left,t_para[i].top);
						}
					}
					createImg4(n);
				}
			};
			
			function createImg4(n){
				var t_picno = $('#txtPicno_'+n).val();
				var t_para = $('#txtPara_'+n).val();
                var t_imgorg = $('#txtImgorg_'+n).val();
				try{
					t_para = JSON.parse(t_para);
				}catch(e){
					console.log('createImg:'+t_para);
				}
				if(t_imgorg.length==0)
					return;
				var image = document.getElementById('imgPic_'+n)
                var imgwidth = 300;
                var imgheight = 100;
                var c = document.getElementById("canvas_"+n);
				$('#imgPic_'+n).attr('src',c.toDataURL());
				image.onload = function() {
					//報表用圖形 縮放為150*50
					$('#canvas_'+n).width(150).height(50);
					c.width = 150;
					c.height = 50;
					$('#canvas_'+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,150,50);
					$('#txtImgdata_'+n).val(c.toDataURL());	
					//------------------------------
				}
			};

            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                for(var i=0;i<q_bbsCount;i++){
                	//106/03/16 長度=0 刪除
                	if(emp($('#txtLengthb_'+i).val()) || dec($('#txtLengthb_'+i).val())==0){
                		$('#btnMinus_'+i).click();
                	}
                }
				
				$('#txtNoa').val(trim($('#txtNoa').val()));
				var t_noa = trim($('#txtNoa').val());
				
                if (q_cur == 1){
                    $('#txtWorker').val(r_name);
                 	/*t_where = "where=^^ noa='" + t_noa + "'^^";
                    q_gt('view_cuc', t_where, 0, 0, 0, "checkCucno_btnOk", r_accy);*/   
                }else{
                    $('#txtWorker2').val(r_name);
                    //wrServer(t_noa);
				}
				
				
				t_bbsordegen=false;
                var t_ordeno='';
                
				for(var i=0;i<q_bbsCount;i++){
                	createImg(i);
                	if(t_ordeno.length==0 && !emp($('#txtOrdeno_'+i).val())){
                		t_ordeno=$('#txtOrdeno_'+i).val();
                	}
                }
                
                if(t_ordeno.length==0){
                	t_bbsordegen=true;
                }
				
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                var t_date = trim($('#txtDatea').val());
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cuc_sf_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	if($('#canvas_'+j).length>0){
						$('#imgPic_'+j).attr('src', $('#txtImgdata_'+j).val());
						showimg(j);
                	}
                	
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('#txtOrdeno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$(this).val(trim($(this).val()));
						});
						
                    	$('#combUcolor_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtUcolor_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
						});
						$('#txtSize_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							 if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
                        	bbsweight(b_seq);
						});
						
						$('#combSpec_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtSpec_'+b_seq).val($('#combSpec_'+b_seq).find("option:selected").text());
							//bbsweight(b_seq);
						});
						
						$('#txtLengthb_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							bbsweight(b_seq);
						});
						
						$('#txtMount1_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							bbsweight(b_seq);
						});
						
						$('#txtWeight_'+j).change(function() {
							weighttotal();
						}).focusin(function() {
							$(this).select();
						});
						
						$('#combClass_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtClass_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").text());
						});
						
						$('#combProduct_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtProduct_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
						});
						
						$('#combParaf_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtParaf_'+b_seq).val($('#combParaf_'+b_seq).find("option:selected").text());
								createImg(b_seq);
							}
						});
						
						$('#combParag_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtParag_'+b_seq).val($('#combParag_'+b_seq).find("option:selected").text());
								createImg(b_seq);
							}
						});
						
						$('#checkMins_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkMins_'+b_seq).prop('checked'))
									$('#txtMins_'+b_seq).val(1);
								else
									$('#txtMins_'+b_seq).val(0);
							}
							weighttotal();
						});
						
						/*$('#checkWaste_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkWaste_'+b_seq).prop('checked'))
									$('#txtWaste_'+b_seq).val(1);
								else
									$('#txtWaste_'+b_seq).val(0);
							}
							weighttotal();
						});
						
						$('#checkHours_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkHours_'+b_seq).prop('checked'))
									$('#txtHours_'+b_seq).val(1);
								else
									$('#txtHours_'+b_seq).val(0);
							}
							weighttotal();
						});
						
						$('#checkRadius_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkRadius_'+b_seq).prop('checked'))
									$('#txtRadius_'+b_seq).val(1);
								else
									$('#txtRadius_'+b_seq).val(0);
							}
							weighttotal();
						});
						
						$('#checkWidth_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkWidth_'+b_seq).prop('checked'))
									$('#txtWidth_'+b_seq).val(1);
								else
									$('#txtWidth_'+b_seq).val(0);
							}
							weighttotal();
						});
						
						$('#checkDime_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#checkDime_'+b_seq).prop('checked'))
									$('#txtDime_'+b_seq).val(1);
								else
									$('#txtDime_'+b_seq).val(0);
							}
							weighttotal();
						});*/
						
						$('#txtPicno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtPicno_', '');
                            $('#btnPicno_'+n).click();
                            
                            /*if($('#btnPic').val()=='成型參數顯示'){
								$('#btnPic').val('成型參數關閉');
								$('.pic').show();
								$('#tbbs').css("width","2350px");
								$('.dbbs').css("width","2350px");
							}*/
                        });
                        
                        $('#txtParaa_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParaa_', '');
                    		createImg(n);
                    		
                    		var t_a=dec($('#txtParaa_'+n).val());
                    		var t_b=dec($('#txtParab_'+n).val());
                    		var t_c=dec($('#txtParac_'+n).val());
                    		var t_d=dec($('#txtParad_'+n).val());
                    		var t_e=dec($('#txtParae_'+n).val());
                    		$('#txtLengthb_'+n).val(round(q_add(q_add(q_add(q_add(t_a,t_b),t_c),t_d),t_e)/100,2));
                    	});
                    	$('#txtParab_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParab_', '');
                    		createImg(n);
                    		var t_a=dec($('#txtParaa_'+n).val());
                    		var t_b=dec($('#txtParab_'+n).val());
                    		var t_c=dec($('#txtParac_'+n).val());
                    		var t_d=dec($('#txtParad_'+n).val());
                    		var t_e=dec($('#txtParae_'+n).val());
                    		$('#txtLengthb_'+n).val(round(q_add(q_add(q_add(q_add(t_a,t_b),t_c),t_d),t_e)/100,2));
                    	});
                    	$('#txtParac_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParac_', '');
                    		createImg(n);
                    		var t_a=dec($('#txtParaa_'+n).val());
                    		var t_b=dec($('#txtParab_'+n).val());
                    		var t_c=dec($('#txtParac_'+n).val());
                    		var t_d=dec($('#txtParad_'+n).val());
                    		var t_e=dec($('#txtParae_'+n).val());
                    		$('#txtLengthb_'+n).val(round(q_add(q_add(q_add(q_add(t_a,t_b),t_c),t_d),t_e)/100,2));
                    	});
                    	$('#txtParad_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParad_', '');
                    		createImg(n);
                    		var t_a=dec($('#txtParaa_'+n).val());
                    		var t_b=dec($('#txtParab_'+n).val());
                    		var t_c=dec($('#txtParac_'+n).val());
                    		var t_d=dec($('#txtParad_'+n).val());
                    		var t_e=dec($('#txtParae_'+n).val());
                    		$('#txtLengthb_'+n).val(round(q_add(q_add(q_add(q_add(t_a,t_b),t_c),t_d),t_e)/100,2));
                    	});
                    	$('#txtParae_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParae_', '');
                    		createImg(n);
                    		var t_a=dec($('#txtParaa_'+n).val());
                    		var t_b=dec($('#txtParab_'+n).val());
                    		var t_c=dec($('#txtParac_'+n).val());
                    		var t_d=dec($('#txtParad_'+n).val());
                    		var t_e=dec($('#txtParae_'+n).val());
                    		$('#txtLengthb_'+n).val(round(q_add(q_add(q_add(q_add(t_a,t_b),t_c),t_d),t_e)/100,2));
                    	});
                    	$('#txtParaf_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParae_', '');
                    		createImg(n);
                    	});
                    	$('#txtParag_'+j).change(function(e){
                    		var n = $(this).attr('id').replace('txtParae_', '');
                    		createImg(n);
                    	});
                        $('#txtMechno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtMechno_', '');
                            $('#btnMechno_'+n).click();
                        });
                        $('#txtMechno2_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtMechno2_', '');
                            $('#btnMechno2_'+n).click();
                        });
                    }
                }
                _bbsAssign();
                change_check();
                $('#lblOrdeno_s').text('訂單編號/訂序');
                $('#lblProduct_s').text('品名');
                $('#lblUcolor_s').text('類別');
                $('#lblSpec_s').text('材質');
                $('#lblSize_s').text('號數');
                $('#lblLengthb_s').text('長度(米)');
                $('#lblClass_s').text('廠牌');
                $('#lblUnit_s').text('單位');
                $('#lblMount1_s').text('支數');
                $('#lblMount_s').text('件數');
                $('#lblWeight_s').text('重量(KG)');
                $('#lblMemo_s').text('備註 (標籤)');
                $('#lblMins_s').text('裁剪完工');
                $('#lblHours_s').text('續接完工');
                $('#lblWaste_s').text('成型完工');
                $('#vewNoa').text('案號');
                $('#vewCust').text('客戶');
                $('#lblSize2_s').text('內部工令');
                $('#lblStyle_s').text('加工型式');
				$('#lblParaa_s').text('參數A');
				$('#lblParab_s').text('參數B');
				$('#lblParac_s').text('參數C');
				$('#lblParad_s').text('參數D');
				$('#lblParae_s').text('參數E');
				$('#lblParaf_s').text('續接參數F');
				$('#lblParag_s').text('續接參數G');
				$('#lblPic_s').text('形狀');
				$('#lblBtime_s').text('顏色1');
				$('#lblEtime_s').text('顏色2');
				$('#lblRadius_s').text('裁剪');
				$('#lblWidth_s').text('續接');
				$('#lblDime_s').text('成型');
				
				if($('#btnImg').val()=='圖型關閉顯示'){
					$('.img').hide();
				}else{
					$('.img').show();
				}
				if($('#btnPic').val()=='成型參數顯示'){
					$('.pic').hide();
				}else{
					$('.pic').show();
				}
				if($('#btnPic2').val()=='續接參數顯示'){
					$('.pic2').hide();
				}else{
					$('.pic2').show();
				}
				bbswidth();
				
				//1050802複製功能
                $('#btnProductCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtProduct_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtProduct_'+i).val())){
	                				$('#txtProduct_'+i).val($('#txtProduct_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnUcolorCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtUcolor_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtUcolor_'+i).val())){
	                				$('#txtUcolor_'+i).val($('#txtUcolor_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnSpecCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtSpec_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtSpec_'+i).val())){
	                				$('#txtSpec_'+i).val($('#txtSpec_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnSizeCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtSize_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtSize_'+i).val())){
	                				$('#txtSize_'+i).val($('#txtSize_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnStyleCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		//106/07/17
                		var t_tmp=$('#txtPicno_0').val();
                		var t_tmp2=$('#txtPicname_0').val();
                		for (var i = 1; i < q_bbsCount; i++) {
                			if(emp($('#txtPicno_'+i).val())){
	                			$('#txtPicno_'+i).val(t_tmp);
	                			$('#txtPicname_'+i).val(t_tmp2);
	                			var n = i;
		                		t_noa = $('#txtPicno_'+n).val();
		                		q_gt('img', "where=^^noa='"+t_noa+"'^^", 0, 0, 0, JSON.stringify({action:"getimg",n:n}),1);
	                		}else{
	                			t_tmp=$('#txtPicno_'+i).val();
                				t_tmp2=$('#txtPicname_'+i).val();
	                		}
                		}
                	}
				});
				
				$('#btnClassCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtClass_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtClass_'+i).val())){
	                				$('#txtClass_'+i).val($('#txtClass_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnMemoCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		/*if(!emp($('#txtMemo_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtMemo_'+i).val())){
	                				$('#txtMemo_'+i).val($('#txtMemo_0').val());
	                			}
	                		}
                		}*/
                		
                		//106/07/17
                		var t_tmp=$('#txtMemo_0').val();
                		for (var i = 1; i < q_bbsCount; i++) {
                			if(emp($('#txtMemo_'+i).val())){
	                			$('#txtMemo_'+i).val(t_tmp);
	                		}else{
	                			t_tmp=$('#txtMemo_'+i).val();
	                		}
                		}
                	}
				});
				
				$('#btnSize2Copy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtSize2_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtSize2_'+i).val())){
	                				$('#txtSize2_'+i).val($('#txtSize2_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				$('#btnBtimeCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		/*if(!emp($('#cmbBtime_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#cmbBtime_'+i).val())){
	                				$('#cmbBtime_'+i).val($('#cmbBtime_0').val());
	                			}
	                		}
                		}*/
                		//106/07/17
                		var t_tmp=$('#cmbBtime_0').val();
                		for (var i = 1; i < q_bbsCount; i++) {
                			if(emp($('#cmbBtime_'+i).val())){
	                			$('#cmbBtime_'+i).val(t_tmp);
	                		}else{
	                			t_tmp=$('#cmbBtime_'+i).val();
	                		}
                		}
                	}
				});
				
				$('#btnEtimeCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		/*if(!emp($('#cmbEtime_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#cmbEtime_'+i).val())){
	                				$('#cmbEtime_'+i).val($('#cmbEtime_0').val());
	                			}
	                		}
                		}*/
                		
                		var t_tmp=$('#cmbEtime_0').val();
                		for (var i = 1; i < q_bbsCount; i++) {
                			if(emp($('#cmbEtime_'+i).val())){
	                			$('#cmbEtime_'+i).val(t_tmp);
	                		}else{
	                			t_tmp=$('#cmbEtime_'+i).val();
	                		}
                		}
                	}
				});
				
				$('#btnMechCopy').click(function() {
                	if(q_cur==1 || q_cur==2){
                		var t_tmp=$('#txtMechno_0').val();
                		var t_tmp2=$('#txtMech_0').val();
                		for (var i = 1; i < q_bbsCount; i++) {
                			if(emp($('#txtMechno_'+i).val())){
	                			$('#txtMechno_'+i).val(t_tmp);
	                			$('#txtMech_'+i).val(t_tmp2);
	                		}else{
	                			t_tmp=$('#txtMechno_'+i).val();
	                			t_tmp2=$('#txtMech_'+i).val();
	                		}
                		}
                	}
				});
				
				$('#btnOrdeCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtOrdeno_0').val())){
                			var t_no2='000';
	                		for (var i = 0; i < q_bbsCount; i++) {
	                			if(emp($('#txtOrdeno_'+i).val())){
	                				$('#txtOrdeno_'+i).val($('#txtOrdeno_0').val());
	                			}
	                			if($('#txtOrdeno_'+i).val()==$('#txtOrdeno_0').val() && !emp($('#txtNo2_'+i).val())){
	                				if(dec(t_no2)<dec($('#txtNo2_'+i).val()))
	                					t_no2=$('#txtNo2_'+i).val();
	                			}else if($('#txtOrdeno_'+i).val()==$('#txtOrdeno_0').val() && emp($('#txtNo2_'+i).val())){
	                				$('#txtNo2_'+i).val(('000'+(dec(t_no2)+1)).slice(-3));
	                				t_no2=$('#txtNo2_'+i).val();
	                			}
	                		}
                		}
                	}
				});
				
				for (var j = 0; j < q_bbsCount; j++) {
                	if($('#canvas_'+j).length>0){
						$('#imgPic_'+j).attr('src', $('#txtImgdata_'+j).val());
						showimg(j)
                	}
                }
            }
            
            function showimg(n){
            	var image = document.getElementById('imgPic_'+n);
            	image.onload = function() {
					var imgwidth = $('#imgPic_'+n).width();
	                var imgheight = $('#imgPic_'+n).height();
	                if($("#canvas_"+n)[0]!=undefined)
						$("#canvas_"+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,150,50);
				}
            }
            
            function q_bbsLenShow( t_start, t_end){
            	for(var i=t_start;i<=t_end;i++)
            	if($('#canvas_'+i).length>0){
					$('#imgPic_'+i).attr('src', $('#txtImgdata_'+i).val());
					var imgwidth = $('#imgPic_'+i).width();
					var imgheight = $('#imgPic_'+i).height();
					$("#canvas_"+i)[0].getContext("2d").drawImage($('#imgPic_'+i)[0],0,0,imgwidth,imgheight,0,0,150,50);
					
            	}
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
            	var t_mount1=dec($('#txtMount1_'+n).val());
            	
            	$('#txtWeight_'+n).val(round(q_mul(q_mul(t_weight,t_lengthb),t_mount1),0));
            	weighttotal()
            }
            
            function weighttotal() {
            	var t_weight=0;
            	for (var j = 0; j < q_bbsCount; j++) {
            		t_weight=q_add(t_weight,dec($('#txtWeight_'+j).val()));
            	}
            	$('#textWeight').val(FormatNumber(t_weight));
			}
			
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                refreshBbm();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                if(!emp($('#txtCustno').val())){
					q_gt('custms', "where=^^noa='"+$('#txtCustno').val()+"'^^ ", 0, 0, 0, "custms");	
				}
            }

            function btnPrint() {
				var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
               	q_box("z_cucp_sf.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
			
			var t_bbsordegen=false;
            function bbsSave(as) {
                if (!as['ordeno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                if(emp(as['ordeno']) && t_bbsordegen)
                	as['ordeno'] = abbm2['noa'];
                if(emp(as['no2']) && t_bbsordegen)
                	as['no2'] = as['noq'];

                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                change_check();
                weighttotal();
                refreshBbm();
                
                if(!emp($('#txtCustno').val())){
					q_gt('custms', "where=^^noa='"+$('#txtCustno').val()+"'^^ ", 0, 0, 0, "custms");
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#btnOrde').attr('disabled', 'disabled');
            	}else{
            		$('#btnOrde').removeAttr('disabled');
                }
                
                change_check();
            }
            
            function refreshBbm() {
                /*if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }*/
            }

            function btnMinus(id) {
                _btnMinus(id);
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function change_check() {
            	if(q_cur==1 || q_cur==2){
            		$('#checkGen').removeAttr('disabled');
            	}else{
            		$('#checkGen').attr('disabled', 'disabled');
            	}
            	if($('#txtGen').val()==0){
					$('#checkGen').prop('checked',false);
				}else{
					$('#checkGen').prop('checked',true);
				}
            	
				for (var i = 0; i < q_bbsCount; i++) {
					if(q_cur==1 || q_cur==2){
						$('#checkMins_'+i).removeAttr('disabled');
						/*$('#checkHours_'+i).removeAttr('disabled');
						$('#checkWaste_'+i).removeAttr('disabled');
						
						$('#checkRadius_'+i).removeAttr('disabled');
						$('#checkWidth_'+i).removeAttr('disabled');
						$('#checkDime_'+i).removeAttr('disabled');*/
					}else{
						$('#checkMins_'+i).attr('disabled', 'disabled');
						/*$('#checkHours_'+i).attr('disabled', 'disabled');
						$('#checkWaste_'+i).attr('disabled', 'disabled');
						
						$('#checkRadius_'+i).attr('disabled', 'disabled');
						$('#checkWidth_'+i).attr('disabled', 'disabled');
						$('#checkDime_'+i).attr('disabled', 'disabled');*/
					}
					if($('#txtMins_'+i).val()==0){
						$('#checkMins_'+i).prop('checked',false);
					}else{
						$('#checkMins_'+i).prop('checked',true);
					}
					/*if($('#txtWaste_'+i).val()==0){
						$('#checkWaste_'+i).prop('checked',false);
					}else{
						$('#checkWaste_'+i).prop('checked',true);
					}
					if($('#txtHours_'+i).val()==0){
						$('#checkHours_'+i).prop('checked',false);
					}else{
						$('#checkHours_'+i).prop('checked',true);
					}
					
					if($('#txtRadius_'+i).val()==0){
						$('#checkRadius_'+i).prop('checked',false);
					}else{
						$('#checkRadius_'+i).prop('checked',true);
					}
					if($('#txtWidth_'+i).val()==0){
						$('#checkWidth_'+i).prop('checked',false);
					}else{
						$('#checkWidth_'+i).prop('checked',true);
					}
					if($('#txtDime_'+i).val()==0){
						$('#checkDime_'+i).prop('checked',false);
					}else{
						$('#checkDime_'+i).prop('checked',true);
					}*/
				}
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
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                border-width: 0px;
                width: 30%;
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
                width: 70%;
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
                width: 98%;
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
                width: 1750px;
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
            #q_acDiv {
                white-space: nowrap;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='cust'>~cust</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno"  type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtCust"  type="text" class="txt c1"/> </td>
						<td align="center"><input id="btnOrde" type="button" value="訂單匯入" ></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMech" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtMech"  type="text" class="txt c1" style="width: 90%;"/>
							<select id="combAccount" class="txt" style="width: 20px;"> </select>
						</td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a</td>
						<td><input id="txtBdate"  type="text" class="txt c1" style="width: 95%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><input id="txtTypea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGen" class="lbl"> </a></td>
						<td>
							<input id="checkGen" type="checkbox"/>
							<input id="txtGen" type="hidden"/>
						</td>
						<td align="center"><input id="btnPic" type="button" value="成型參數顯示"></td>
						<td align="center"><input id="btnPic2" type="button" value="續接參數顯示"></td>
						<td align="center"><input id="btnImg" type="button" value="圖型關閉"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="textWeight" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;'>
						<td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
						<td align="center" style="width: 200px;">
							<a id='lblOrdeno_s'> </a>
							<input class="btn"  id="btnOrdeCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblProduct_s'> </a>
							<input class="btn"  id="btnProductCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblUcolor_s'> </a>
							<input class="btn"  id="btnUcolorCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblSpec_s'> </a>
							<input class="btn"  id="btnSpecCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:85px;">
							<a id='lblSize_s'> </a>
							<input class="btn"  id="btnSizeCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:120px;">
							<a id='lblStyle_s'> </a>
							<input class="btn"  id="btnStyleCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:100px;display: none;" class="pic"><a id='lblParaa_s'> </a></td>
						<td style="width:100px;display: none;" class="pic"><a id='lblParab_s'> </a></td>
						<td style="width:100px;display: none;" class="pic"><a id='lblParac_s'> </a></td>
						<td style="width:100px;display: none;" class="pic"><a id='lblParad_s'> </a></td>
						<td style="width:100px;display: none;" class="pic"><a id='lblParae_s'> </a></td>
						<td style="width:110px;display: none;" class="pic2"><a id='lblParaf_s'> </a></td>
						<td style="width:110px;display: none;" class="pic2"><a id='lblParag_s'> </a></td>
						<td style="width:200px;" class="img"><a id='lblPic_s'> </a></td>
						<td style="width:85px;"><a id='lblLengthb_s'> </a></td>
						<!--<td style="width:55px;"><a id='lblUnit_s'> </a></td>-->
						<td style="width:85px;"><a id='lblMount1_s'> </a></td>
						<td style="width:85px;"><a id='lblMount_s'> </a></td>
						<td style="width:85px;"><a id='lblWeight_s'> </a></td>
						<td style="width:120px;">
							<a id='lblClass_s'> </a>
							<input class="btn"  id="btnClassCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblMemo_s'> </a>
							<input class="btn"  id="btnMemoCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblSize2_s'> </a>
							<input class="btn"  id="btnSize2Copy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:90px;">
							<a id='lblBtime_s'> </a>
							<input class="btn" id="btnBtimeCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:90px;">
							<a id='lblEtime_s'> </a>
							<input class="btn" id="btnEtimeCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<td style="width:150px;">
							<a id='lblMech_s'>剪裁機台</a>
							<input class="btn" id="btnMechCopy" type="button" value='≡' style="font-weight: bold;"  />
						</td>
						<!--<td style="width:150px;"><a id='lblMech2_s'>成型機台</a></td>-->
						<!--<td style="width:40px;"><a id='lblRadius_s'> </a></td>
						<td style="width:40px;"><a id='lblWidth_s'> </a></td>
						<td style="width:40px;"><a id='lblDime_s'> </a></td>-->
						<td style="width:40px;"><a id='lblMins_s'> </a></td>
						<!--<td style="width:40px;"><a id='lblHours_s'> </a></td>
						<td style="width:40px;"><a id='lblWaste_s'> </a></td>-->
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td>
							<input id="txtOrdeno.*" type="text" class="txt c1" />
							<input id="txtNo2.*" type="text" class="txt c1" />
							<input id="txtNoq.*" type="hidden"/>
						</td>
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
						<td>
							<input class="txt" id="txtPicno.*" type="text" style="width:95%;"/>
							<input class="txt" id="txtPicname.*" type="text" style="width:95%;"/>
							<input class="txt" id="txtPara.*" type="text" style="display:none;"/>
							<input id="btnPicno.*" type="button" style="display:none;">
						</td>
						<td class="pic" style="display: none;"><input id="txtParaa.*" type="text" class="txt num c1" /></td>
						<td class="pic" style="display: none;"><input id="txtParab.*" type="text" class="txt num c1" /></td>
						<td class="pic" style="display: none;"><input id="txtParac.*" type="text" class="txt num c1" /></td>
						<td class="pic" style="display: none;"><input id="txtParad.*" type="text" class="txt num c1" /></td>
						<td class="pic" style="display: none;"><input id="txtParae.*" type="text" class="txt num c1" /></td>
						<td class="pic2" style="display: none;">
							<input id="txtParaf.*" type="text" class="txt c1" style="width: 70%;" />
							<select id="combParaf.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td class="pic2" style="display: none;">
							<input id="txtParag.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combParag.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td class="img">
							<canvas id="canvas.*" width="150" height="50"> </canvas>
							<img id="imgPic.*" src="" style="display:none;"/>
							<textarea id="txtImgorg.*" style="display:none;"> </textarea>
							<textarea id="txtImgdata.*" style="display:none;"> </textarea>
							<textarea id="txtImgbarcode.*" style="display:none;"> </textarea>
						</td>
						<td><input id="txtLengthb.*" type="text" class="txt num c1" /></td>
						<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtMount1.*" type="text" class="txt num c1"/></td>
						<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
						<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
						<td>
							<input id="txtClass.*" type="text" class="txt c1" style="width: 70%;"/>
							<select id="combClass.*" class="txt" style="width: 20px;"> </select>
						</td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtSize2.*" type="text" class="txt c1"/></td>
						<td><select id="cmbBtime.*" class="txt c1"> </select></td>
						<td><select id="cmbEtime.*" class="txt c1"> </select></td>
						<td>
							<input id="txtMechno.*" type="text" class="txt c1"/>
							<input id="txtMech.*" type="text" class="txt c1"/>
							<input id="btnMechno.*" type="button" style="display:none;">
						</td>
						<!--<td>
							<input id="txtMechno2.*" type="text" class="txt c1"/>
							<input id="txtMech2.*" type="text" class="txt c1"/>
							<input id="btnMechno2.*" type="button" style="display:none;">
						</td>-->
						<!--<td>
							<input id="checkRadius.*" type="checkbox"/>
							<input id="txtRadius.*" type="hidden"/>
						</td>
						<td>
							<input id="checkWidth.*" type="checkbox"/>
							<input id="txtWidth.*" type="hidden"/>
						</td>
						<td>
							<input id="checkDime.*" type="checkbox"/>
							<input id="txtDime.*" type="hidden"/>
						</td>-->
						<td>
							<input id="checkMins.*" type="checkbox"/>
							<input id="txtMins.*" type="hidden"/>
						</td>
						<!--<td>
							<input id="checkHours.*" type="checkbox"/>
							<input id="txtHours.*" type="hidden"/>
						</td>
						<td>
							<input id="checkWaste.*" type="checkbox"/>
							<input id="txtWaste.*" type="hidden"/>
						</td>-->
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
