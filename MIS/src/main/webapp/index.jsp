<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成员列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="modal fade" id="memberUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">成员修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="memberName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@atguigu.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="member_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="memberAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">成员添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" name="mName" class="form-control"
									id="memberName_add_input" placeholder="memberName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@xx.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="deptId">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="member_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>爪哇部落成员信息管理系统</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="member_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="member_delete_all_btn">删除</button>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="members_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>email</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>

	<script type="text/javascript">
		var totalRecord,currentPage;
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/members",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//1、解析并显示成员数据
					build_members_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);

				}
			});
		}

		function build_members_table(result) {
			$("#members_table tbody").empty();
			var members = result.extend.pageInfo.list;
			$.each(members, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var memberIdTd = $("<td></td>").append(item.mId);
				var memberNameTd = $("<td></td>").append(item.mName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.dName);

				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit-id", item.mId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				delBtn.attr("del-id", item.mId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);

				$("<tr></tr>").append(checkBoxTd).append(memberIdTd).append(memberNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#members_table tbody");
			});
		}

		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总"
							+ result.extend.pageInfo.pages + "页,总"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");

			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {

				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});

			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		$("#member_add_modal_btn").click(function() {
			reset_form("#memberAddModal form");
			getDepts("#memberAddModal select");
			$("#memberAddModal").modal({
				backdrop : "static"
			});
		});

		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH }/depts",
				type : "GET",
				success : function(result) {
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.dName).attr("value", this.dId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		function validate_add_form() {
			var memberName = $("#memberName_add_input").val();			
			var regName = /^[\u2E80-\u9FFF]{2,5}/;
			if (!regName.test(memberName)) {
				show_validate_msg("#memberName_add_input", "error", "姓名只可为中文");
				return false;
			} else {
				show_validate_msg("#memberName_add_input", "success", "");
			}

			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}

		function show_validate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		$("#memberName_add_input").change(
				function() {
					var memberName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "memberName=" + memberName,
						type : "POST",
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#memberName_add_input",
										"success", "姓名可用");
								$("#member_save_btn")
										.attr("ajax-va", "success");
							} else {
								show_validate_msg("#memberName_add_input",
										"error", result.extend.va_msg);
								$("#member_save_btn").attr("ajax-va", "error");
							}
						}
					});
				});

		$("#member_save_btn").click(function() {
			if (!validate_add_form()) {
				return false;
			}
			if ($(this).attr("ajax-va") == "error") {
				return false;
			}
			$.ajax({
				url : "${APP_PATH }/member",
				type : "POST",
				data : $("#memberAddModal form").serialize(),
				success : function(result) {
					if (result.code == 100) {
						$("#memberAddModal").modal('hide');
						to_page(totalRecord);
					} else {
						if (undefined != result.extend.errorFields.email) {
							show_validate_msg(
									"#email_add_input",
									"error",
									result.extend.errorFields.email);
						}
						if (undefined != result.extend.errorFields.memberName) {
							show_validate_msg(
									"#memberName_add_input",
									"error",
									result.extend.errorFields.memberName);
						}
					}
				}
			});
		});
		
		$(document).on("click", ".edit_btn", function() {
			getDepts("#memberUpdateModal select");
			getMember($(this).attr("edit-id"));
			$("#member_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#memberUpdateModal").modal({
				backdrop : "static"
			});
		});

		function getMember(id) {
			$.ajax({
				url : "${APP_PATH}/member/" + id,
				type : "GET",
				success : function(result) {
					var memberData = result.extend.member;
					$("#memberName_update_static").text(memberData.mName);
					$("#email_update_input").val(memberData.email);
					$("#memberUpdateModal input[name=gender]").val(
							[ memberData.gender ]);
					$("#memberUpdateModal select").val([ memberData.deptId ]);
				}
			});
		}
		
		$("#member_update_btn").click(function() {
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}

			$.ajax({
				url : "${APP_PATH}/member/" + $(this).attr("edit-id"),
				type : "PUT",
				data : $("#memberUpdateModal form").serialize(),
				success : function(result) {
					$("#memberUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});
		
		$(document).on("click", ".delete_btn", function() {
			var memberName = $(this).parents("tr").find("td:eq(2)").text();
			var memberId = $(this).attr("del-id");
			if (confirm("确认删除【" + memberName + "】吗？")) {
				$.ajax({
					url : "${APP_PATH}/member/" + memberId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		});

		$(document).on("click",".check_item", function() {
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked", flag);
		});
		
		$("#member_delete_all_btn").click(
				function() {
					var memberNames = "";
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						memberNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});

					memberNames = memberNames.substring(0, memberNames.length - 1);
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					if (confirm("确认删除【" + memberNames + "】吗？")) {
						$.ajax({
							url : "${APP_PATH}/member/" + del_idstr,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								to_page(currentPage);
							}
						});
					}
				});
	</script>
</body>
</html>