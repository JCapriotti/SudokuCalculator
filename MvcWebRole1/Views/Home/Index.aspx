<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<ul data-role="listview">
	<li><%: Html.ActionLink("Enter Helper", MVC.Home.Solve(), new Dictionary<string, object> { { "data-transition", "slide" } } ) %></li>
	<li><a href="http://krazydad.com/killersudoku/">Find Killer Sudoku Puzzles</a></li>
</ul>

</asp:Content>

