<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
#chatting {
	position: fixed;
	z-index: 30;
	bottom: 4%;
	left: 2%;
	width: 50px;
}
</style>

<script>
	$(document).ready(function() {
		$("#main").hide();
		$("#chatting").on("click", function() {
			$("#main").toggle();
		})
	})
</script>

<img id="chatting" class="lfSkuP"
	src="/images/ch-new-symbol-powered.png" alt="버그">



<div id="ch-plugin">
	<div id="ch-plugin-core">
		<div data-ch-testid="full-screen-push-message" hidden=""
			class="FullScreenPushMessagestyled__Wrapper-nxoc25-9 jNIDNu PushMessagestyled__PCPopupMessage-vqm8p7-1 egLHoW"
			style="z-index: 100000000 !important;">
			<div class="FullScreenPushMessagestyled__MainWrapper-nxoc25-8 fCsTtf">
				<div
					class="FullScreenPushMessagestyled__SVGIconWrapper-nxoc25-0 kmAVFX">
					<div name="cancel" size="16" width="24" height="24"
						class="SVGIconstyled__SVGIcon-sc-15isf0b-0 cQJNXd"></div>
				</div>
				<div class="FullScreenPushMessagestyled__Header-nxoc25-3 fzszwe">
					<div size="24" radius="8px"
						class="Avatarstyled__Avatar-yfy5xq-0 jUtegZ"></div>
					<div class="FullScreenPushMessagestyled__Name-nxoc25-2 fqimYT">(알
						수 없음)</div>
					<div
						class="FullScreenPushMessagestyled__HeaderContent-nxoc25-1 dVbCKK">9:00
						AM</div>
				</div>
				<div class="FullScreenPushMessagestyled__Content-nxoc25-7 Eohuv">
					<div class="FullScreenPushMessagestyled__Text-nxoc25-4 kOiAv"></div>
				</div>
			</div>
		</div>
		<div size="600" class="Screenstyled__Screen-sc-3ge3qf-0 kJRlZG"></div>
		<div data-ch-testid="launcher"
			class="Launcherstyled__Wrapper-oef45p-0 lcqxVm" hidden="">
			<div class="Launcherstyled__TextLauncher-oef45p-1 lbMRR">
				<div
					class="Launcherstyled__TextLauncherContent-oef45p-2 inNMmP textLauncherContent">문제가
					생겼나요?</div>
				<div
					class="Launcherstyled__TextLauncherIcon-oef45p-3 lfSkuP textLauncherIcon">
					<div data-ch-testid="badge" hidden=""
						class="Badgestyled__Badge-sc-1ztqq4-0 Launcherstyled__Badge-oef45p-5 bZpFRQ">0</div>
				</div>
			</div>
		</div>
	</div>
	<div id="ch-plugin-script" class="ch-desk-messenger leftPosition">
		<iframe id="ch-plugin-script-iframe"
			style="position: relative !important; height: 100% !important; width: 100% !important; border: none !important;"></iframe>
	</div>
</div>


