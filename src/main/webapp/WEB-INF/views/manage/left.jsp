<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/adm.css">


</head>
<body>
	<div class="tWrap go_skin_default ">
		<div class="wrap_gnb admin_side_new">
			<div>
				<div class="head_sidebar">
					<!-- gnb -->
					<h1 class="logo">
						<div class="site">Site Admin</div>
						<div class="company">AI_Interview</div>
					</h1>
					<a class="btn_fold" title="접기"> <span class="ic_adm ic_fold"></span>
					</a> <a class="btn_fold" title="펼치기" style="display: none;"> <span
						class="ic_adm ic_unfold"></span>
					</a>

					<!--  메뉴 검색   -->
					<!-- 					<form onsubmit="return false;" class="search dark"> -->
					<!-- 						<fieldset> -->
					<!-- 							<legend>메뉴 검색</legend> -->
					<!-- 							<input id="filteringText" type="text" autocomplete="off"> -->
					<!-- 							<span class="ic_adm ic_search" title="검색"></span> <a -->
					<!-- 								class="btn_cancel_s_w"> <span class="ic_adm ic_cancel_s_w" -->
					<!-- 								title="삭제"></span> -->
					<!-- 							</a> -->
					<!-- 						</fieldset> -->
					<!-- 					</form> -->
				</div>
				<div class="gnb simplebar-content-wrapper" id="sidebar_wrapper"
					style="height: 828.55px;" data-simplebar="init">
					<div class="simplebar-wrapper" style="margin: 0px -16px;">
						<div class="simplebar-height-auto-observer-wrapper">
							<div class="simplebar-height-auto-observer"></div>
						</div>
						<div class="simplebar-mask">
							<div class="simplebar-offset" style="right: 0px; bottom: 0px;">
								<div class="simplebar-content-wrapper"
									style="height: 100%; overflow: hidden;">
									<div class="simplebar-content" style="padding: 0px 16px;">
										<div id="null_data" class="null_data" style="display: none;">
											<span class="txt">검색 결과가 없습니다.</span>
										</div>

										<div id="menu-content" class="simplebar-content">
											<!-- 최근 사용 메뉴, 즐겨찾기 -->
											<!-- 											<div class="gnb_group"> -->
											<!-- 												<div class="gnb_header">My</div> -->
											<!-- 												<div class="gnb_memu" id="recentlyMenu"> -->
											<!-- 													<a class="gnb_tit folded"> <span -->
											<!-- 														class="ic_adm ic_accordion"></span> <span class="txt">최근 -->
											<!-- 															사용한 메뉴</span> -->
											<!-- 													</a> -->

											<!-- 													<ul class="gnb_sub" style="display: none;"> -->
											<!-- 														<li name="D-c-2" id="recently_D-c-2"><a class="tit"> -->
											<!-- 																<span class="txt">전체 게시판 통계</span> -->
											<!-- 														</a></li> -->
											<!-- 														<li name="A-a" id="recently_A-a"><a class="tit"> -->
											<!-- 																<span class="txt">서비스 정보</span> -->
											<!-- 														</a></li> -->
											<!-- 														<li name="D-o-0" id="recently_D-o-0"><a class="tit"> -->
											<!-- 																<span class="txt">자료실 기본설정</span> -->
											<!-- 														</a></li> -->
											<!-- 														<li name="D-b-0" id="recently_D-b-0"><a class="tit"> -->
											<!-- 																<span class="txt">결재 양식</span> -->
											<!-- 														</a></li> -->
											<!-- 														<li name="C-b" id="recently_C-b"><a class="tit"> -->
											<!-- 																<span class="txt">멤버통합관리</span> -->
											<!-- 														</a></li> -->
											<!-- 													</ul> -->
											<!-- 												</div> -->
											<!-- 												<div id="favoritedMenu" class="gnb_memu"> -->
											<!-- 													<a class="gnb_tit folded"> <span -->
											<!-- 														class="ic_adm ic_accordion"></span> <span class="txt">즐겨찾기</span> -->
											<!-- 													</a> -->

											<!-- 													<ul class="gnb_sub" style="display: none;"></ul> -->
											<!-- 												</div> -->
											<!-- 											</div> -->


											<div id="sidebar" class="gnb_group">
												<div class="gnb_header">Management</div>
												<div id="management_menu" style="padding: 0px;">
													<div class="gnb_memu" name="A" id="root_A">
														<a class="gnb_tit folded"> 
															<span class="ic_adm ic_accordion"></span> 
															<span class="txt">회원 관리</span>
														</a>
														<ul class="gnb_sub" style="display: none;">
															<li name="A-a" id="root_A-a">
																<a class="tit folded">
																	<span class="txt">회원 목록</span>
																</a>
															</li>
															<li name="A-b" id="root_A-b">
																<a class="tit folded">
																	<span class="txt">회원 관리</span>
																</a>
															</li>
															<li name="A-c" id="root_A-c">
																<a class="tit folded">
																	<span class="txt">회원 통계</span>
																</a>
															</li>
															<li name="A-d" id="root_A-d"><a class="tit folded"><span
																	class="txt">관리자 권한 설정</span></a></li>
														</ul>
													</div>
													<div class="gnb_memu" name="B" id="root_B">
														<a class="gnb_tit folded"> 
															<span class="ic_adm ic_accordion"></span> 
															<span class="txt">게시판 관리</span>
														</a>
														<ul class="gnb_sub" style="display: none;">
															<li name="D-c" id="root_D-c">
																<a class="tit">
																	<span class="ic_adm ic_accordion_s"></span>
																	<span class="txt">게시판</span>
																</a>
																<ul class="gnb_sub" style="display: block;">
																	<li name="D-c-0" id="root_D-c-0">
																		<a class="tit folded">
																			<span class="txt">말머리 관리</span></a></li>
																	<li name="D-c-1" id="root_D-c-1">
																		<a class="tit folded">
																			<span class="txt">게시판 통계</span>
																		</a>
																	</li>
																</ul>
															</li>
														</ul>
													</div>
													<div class="gnb_memu" name="C" id="root_C">
														<a class="gnb_tit folded"> <span
															class="ic_adm ic_accordion"></span> <span class="txt">요금제
																관리</span>
														</a>
														<ul class="gnb_sub" style="display: none;">
															<li name="C-a" id="root_C-a"><a class="tit folded"><span
																	class="txt">조직설계</span></a></li>
															<li name="C-b" id="root_C-b"><a class="tit folded"><span
																	class="txt">멤버통합관리</span></a></li>
															<li name="C-c" id="root_C-c"><a class="tit folded"><span
																	class="txt">직위체계</span></a></li>
															<li name="C-d" id="root_C-d"><a class="tit folded"><span
																	class="txt">조직 일괄등록</span></a></li>
															<li name="C-e" id="root_C-e"><a class="tit folded"><span
																	class="txt">조직 삭제목록</span></a></li>
														</ul>
													</div>
													<div class="gnb_memu gnb_menu_manage" name="D" id="root_D">
														<a class="gnb_tit"> <span class="ic_adm ic_accordion"></span>
															<span class="txt">면접 관리</span>
														</a>
														<ul class="gnb_sub" style="display: block;">
															<li name="D-a" id="root_D-a"><a class="tit folded">
																	<span class="ic_adm ic_accordion_s"></span> <span
																	class="txt">면접 관리</span>
															</a>
																<ul class="gnb_sub" style="display: none;">
																	<li name="D-a-0" id="root_D-a-0"><a
																		class="tit folded"> <span class="txt">면접 목록</span>
																	</a></li>
																	<li name="D-a-1" id="root_D-a-1"><a
																		class="tit folded"> <span class="txt">면접 통계</span>
																	</a></li>
																</ul></li>
															<li name="D-b" id="root_D-b">
																<a class="tit folded">
																	<span class="ic_adm ic_accordion_s"></span> 
																	<span class="txt">인재상관리</span>
																</a>
																<ul class="gnb_sub" style="display: none;">
																	<li name="D-b-0" id="root_D-b-0"><a
																		class="tit folded"> <span class="txt">인재상
																				설정</span>
																	</a></li>
																	<li name="D-b-1" id="root_D-b-1"><a
																		class="tit folded"> <span class="txt">키워드
																				설정</span>
																	</a></li>
																	<li name="D-b-2" id="root_D-b-2"><a
																		class="tit folded"> <span class="txt">인재상
																				통계</span>
																	</a></li>
																	<li name="D-b-3" id="root_D-b-3"><a
																		class="tit folded"> <span class="txt">키워드
																				통계</span>
																	</a></li>
																</ul></li>
															<li name="D-c" id="root_D-c"><a class="tit"> <span
																	class="ic_adm ic_accordion_s"></span> <span class="txt">질문
																		관리</span>
															</a>
																<ul class="gnb_sub" style="display: block;">
																	<li name="D-c-0" id="root_D-c-0"><a
																		class="tit folded"> <span class="txt">질문
																				기본설정</span>
																	</a></li>
																	<li name="D-c-1" id="root_D-c-1"><a
																		class="tit folded"> <span class="txt">질문 통계</span>
																	</a></li>
																</ul></li>
															<li name="D-d" id="root_D-d"><a class="tit folded">
																	<span class="ic_adm ic_accordion_s"></span> <span
																	class="txt">스크립트 관리</span>
															</a>
																<ul class="gnb_sub" style="display: none;">
																	<li name="D-d-0" id="root_D-d-0"><a
																		class="tit folded"> <span class="txt">스크립트
																				설정</span>
																	</a></li>
																	<li name="D-d-1" id="root_D-d-1"><a
																		class="tit folded"> <span class="txt">스크립트
																				통계</span>
																	</a></li>
																</ul></li>
															<li name="D-e" id="root_D-e"><a class="tit folded">
																	<span class="ic_adm ic_accordion_s"></span> <span
																	class="txt">키워드 관리</span>
															</a>
																<ul class="gnb_sub" style="display: none;">
																	<li name="D-e-0" id="root_D-e-0"><a
																		class="tit folded"> <span class="txt">키워드
																				설정</span>
																	</a></li>
																	<li name="D-e-1" id="root_D-e-1"><a
																		class="tit folded"> <span class="txt">키워드
																				통계</span>
																	</a></li>
																</ul></li>
														</ul>
														</li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>



						<div class="simplebar-placeholder"
							style="width: auto; height: 757px;"></div>
					</div>
					<div class="simplebar-track simplebar-horizontal"
						style="visibility: hidden;">
						<div class="simplebar-scrollbar"
							style="transform: translate3d(0px, 0px, 0px); display: none;"></div>
					</div>
					<div class="simplebar-track simplebar-vertical"
						style="visibility: hidden;">
						<div class="simplebar-scrollbar"
							style="height: 647px; transform: translate3d(0px, 0px, 0px); display: none;"></div>
					</div>
				</div>
				<!-- //gnb -->
			</div>
		</div>
	</div>
	
	<div>
<span class="btn_tool" id="down_account_list"><span class="ic_adm ic_download"></span><span class="txt">목록 다운로드</span></span>
<span class="btn_tool" id="downloadBatchRegister"><span class="ic_adm ic_shortcut"></span><span class="txt">일괄 등록</span></span>
<span class="btn_tool" id="createNewMember">
			<span class="ic_adm ic_plus"></span>
			<span class="txt">멤버 생성</span>
		</span>
		<span class="btn_tool" id="deleteMembers">
			<span class="ic_adm ic_delete"></span>
			<span class="txt">멤버 삭제</span>
		</span>
	</div>

</body>
</html>