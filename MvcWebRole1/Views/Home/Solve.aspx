<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<form>
			<div class="ui-body ui-body-c">
				<div data-role="fieldcontain">
					<label for="sum">
						Sum:</label>
					<input type="number" name="sum" id="sum" value="" />
				</div>
				<div data-role="fieldcontain">
					<label for="count">
						Count:</label>
					<input type="number" name="count" id="count" value="" />
				</div>
				<div data-role="fieldcontain">
					<label for="include">
						Must Include:</label>
					<input type="number" name="include" id="include" value="" />
				</div>
				<div data-role="fieldcontain">
					<label for="exclude">
						Can't Include:</label>
					<input type="number" name="exclude" id="exclude" value="" />
				</div>
				<div><input data-inline="true" type="reset" id="clearForm" value="Clear"/></div>
			</div> 
			</form>
		</div>
		<div class="ui-block-b" id="resultBlock">
			<div class="ui-bar ui-bar-e">
				<h3>Results</h3>
				<div id="result">
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script>

		$(function () {
			$('input').keyup(calculateForm);
			$('#clearForm').click(resetForm);
			resetForm();
		});

		function calculateForm() {
			$.post(
 				'/Home/Solve',
 				$('form').serialize(),
 				function (data) {
 					var result = '';

 					if (data) {
 						if (data.Common.length > 0) {
 							result = data.Common.toString().replace( /,/gi , ' ') + ' {' + '<br>';
 						}

 						$.each(data.Sets, function(index, value) {
 							if (data.Common.length > 0) {
 								result += ' &nbsp;&nbsp;';
 							}
 							result += value.toString().replace( /,/gi , ' ') + '<br>';
 						});

 						if (data.Common.length > 0) {
 							result += '}';
 						}
 					}
 					$('#result').html(result);
 				},
 				'json'
			);
 			}
		
		function resetForm() {
			$('#sum').focus();
			$('#result').html('');
		}
		
	</script>
</asp:Content>
