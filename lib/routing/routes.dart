const rootRoute = "/home";

const authenticationPageRoute = '/auth';
const layoutRoute = '/layout';
const pageControllerRoute = '/page_controller';

const homePageDisplayName = "Início";
const homePageRoute = "/home";

const addPageDisplayName = "Adicionar";
const addPageRoute = "/add";

const listsPageDisplayName = "Listas";
const listsPageRoute = "/lists";

const myAccountPageDisplayName = "Minha conta";
const myAccountPageRoute = "/my_account";

const serviceOrderPageDisplayName = "Ordem de serviço";
const serviceOrderPageRoute = "/service_order";

const registerBusinessPageRoute = "/register_business";
const registerUnityPageRoute = '/register_unity';
const registerMechanicalPageRoute = '/register_mechanical';
const registerRequesterPageRoute = '/register_requester';
const registerApproverPageRoute = '/register_approver';
const registerEquipmentsPageRoute = '/register_equipments';
const registerPartsPageRoute = '/register_parts';
const registerUserPageRoute = '/register_user';

const unityViewPageRoute = '/unity_view';

class MenuItem {
  final String name;
  final String assetPath;
  final String route;

  MenuItem(this.name, this.assetPath, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(homePageDisplayName, 'assets/icons/home.svg', homePageRoute),
  MenuItem(addPageDisplayName, 'assets/icons/add.svg', addPageRoute),
  MenuItem(listsPageDisplayName, 'assets/icons/lists.svg', listsPageRoute),
  MenuItem(myAccountPageDisplayName, 'assets/icons/account.svg', myAccountPageRoute),
];
