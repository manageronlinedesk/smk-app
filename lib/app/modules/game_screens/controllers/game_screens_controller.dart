import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';

class GameScreensController extends BaseController {
  HomeController controller = HomeController();

  List<String> doublePannaSuggestionList = ['550','668', '244','299','226', '488', '334', '677', '118', '100', '119', '155', '227', '335','344', '399', '588','669', '200', '110', '228', '255', '336', '499', '660', '688', '778', '300', '166', '229', '337', '355', '445', '599', '779', '788', '400', '112', '220', '266', '338', '446', '455', '699', '770', '500', '113', '122', '177', '339', '366', '447', '799', '889', '600', '114', '277', '330', '448', '466', '556', '880', '899', '700', '115', '133', '188', '223', '377', '449', '557', '566', '800', '116', '224', '233', '288', '440', '477', '558', '990', '900', '117', '144', '199', '225', '388', '559', '577', '667',
  ];

  List<String> fullSangamOpenPannaSuggestionList = ['127', '136', '190', '235', '280', '279', '370', '389', '459', '460', '479', '578', '128', '137', '146', '236', '245', '290', '380', '470', '489', '560', '579', '678', '129', '138', '147', '156', '237', '246', '345', '390', '480', '570', '589', '679', '120', '139', '148', '157', '238', '247', '256', '346', '490', '580', '670', '689', '130', '149', '158', '167', '239', '248', '257', '347', '356', '590', '680', '789', '140', '159', '168', '230', '249', '258', '267', '348', '357', '456', '690', '780', '123', '150', '169', '178', '240', '259', '268', '349', '358', '457', '367', '790', '124', '160', '179', '250', '269', '278', '340', '359', '368', '458', '467', '890', '125', '134', '170', '189', '260', '279', '350', '369', '378', '459', '468', '567', '126', '135', '180', '234', '270', '289', '360', '379', '450', '469', '478', '568', '550', '668', '244', '299', '226', '488', '334', '677', '118', '100', '119', '155', '227', '335', '344', '399', '588', '669', '200', '110', '228', '255', '336', '499', '660', '688', '778', '300', '166', '229', '337', '355', '445', '599', '779', '788', '400', '112', '220', '266', '338', '446', '455', '699', '770', '500', '113', '122', '177', '339', '366', '447', '799', '889', '600', '114', '277', '330', '448', '466', '556', '880', '899', '700', '115', '133', '188', '223', '377', '449', '557', '566', '800', '116', '224', '233', '288', '440', '477', '558', '990', '900', '117', '144', '199', '225', '388', '559', '577', '667', '000', '111', '222', '333', '444', '555', '666', '777', '888', '999'];

  List<String> fullSangamClosePannaSuggestionList = ['127', '136', '190', '235', '280', '279', '370', '389', '459', '460', '479', '578', '128', '137', '146', '236', '245', '290', '380', '470', '489', '560', '579', '678', '129', '138', '147', '156', '237', '246', '345', '390', '480', '570', '589', '679', '120', '139', '148', '157', '238', '247', '256', '346', '490', '580', '670', '689', '130', '149', '158', '167', '239', '248', '257', '347', '356', '590', '680', '789', '140', '159', '168', '230', '249', '258', '267', '348', '357', '456', '690', '780', '123', '150', '169', '178', '240', '259', '268', '349', '358', '457', '367', '790', '124', '160', '179', '250', '269', '278', '340', '359', '368', '458', '467', '890', '125', '134', '170', '189', '260', '279', '350', '369', '378', '459', '468', '567', '126', '135', '180', '234', '270', '289', '360', '379', '450', '469', '478', '568', '550', '668', '244', '299', '226', '488', '334', '677', '118', '100', '119', '155', '227', '335', '344', '399', '588', '669', '200', '110', '228', '255', '336', '499', '660', '688', '778', '300', '166', '229', '337', '355', '445', '599', '779', '788', '400', '112', '220', '266', '338', '446', '455', '699', '770', '500', '113', '122', '177', '339', '366', '447', '799', '889', '600', '114', '277', '330', '448', '466', '556', '880', '899', '700', '115', '133', '188', '223', '377', '449', '557', '566', '800', '116', '224', '233', '288', '440', '477', '558', '990', '900', '117', '144', '199', '225', '388', '559', '577', '667', '000', '111', '222', '333', '444', '555', '666', '777', '888', '999'];

  List<String> halfSangamOpenPannaSuggestionList = ['127', '136', '190', '235', '280', '279', '370', '389', '459', '460', '479', '578', '128', '137', '146', '236', '245', '290', '380', '470', '489', '560', '579', '678', '129', '138', '147', '156', '237', '246', '345', '390', '480', '570', '589', '679', '120', '139', '148', '157', '238', '247', '256', '346', '490', '580', '670', '689', '130', '149', '158', '167', '239', '248', '257', '347', '356', '590', '680', '789', '140', '159', '168', '230', '249', '258', '267', '348', '357', '456', '690', '780', '123', '150', '169', '178', '240', '259', '268', '349', '358', '457', '367', '790', '124', '160', '179', '250', '269', '278', '340', '359', '368', '458', '467', '890', '125', '134', '170', '189', '260', '279', '350', '369', '378', '459', '468', '567', '126', '135', '180', '234', '270', '289', '360', '379', '450', '469', '478', '568', '550', '668', '244', '299', '226', '488', '334', '677', '118', '100', '119', '155', '227', '335', '344', '399', '588', '669', '200', '110', '228', '255', '336', '499', '660', '688', '778', '300', '166', '229', '337', '355', '445', '599', '779', '788', '400', '112', '220', '266', '338', '446', '455', '699', '770', '500', '113', '122', '177', '339', '366', '447', '799', '889', '600', '114', '277', '330', '448', '466', '556', '880', '899', '700', '115', '133', '188', '223', '377', '449', '557', '566', '800', '116', '224', '233', '288', '440', '477', '558', '990', '900', '117', '144', '199', '225', '388', '559', '577', '667', '000', '111', '222', '333', '444', '555', '666', '777', '888', '999'];

  List<String> halfSangamClosePannaSuggestionList = ['127','136','190','235','280','279','370','389','459','460','479','578','128','137','146','236','245','290','380','470','489','560','579','678','129','138','147','156','237','246','345','390','480','570','589','679','120','139','148','157','238','247','256','346','490','580','670','689','130','149','158','167','239','248','257','347','356','590','680','789','140','159','168','230','249','258','267','348','357','456','690','780','123','150','169','178','240','259','268','349','358','457','367','790','124','160','179','250','269','278','340','359','368','458','467','890','125','134','170','189','260','279','350','369','378','459','468','567','126','135','180','234','270','289','360','379','450','469','478','568','550','668','244','299','226','488','334','677','118','100','119','155','227','335','344','399','588','669','200','110','228','255','336','499','660','688','778','300','166','229','337','355','445','599','779','788','400','112','220','266','338','446','455','699','770','500','113','122','177','339','366','447','799','889','600','114','277','330','448','466','556','880','899','700','115','133','188','223','377','449','557','566','800','116','224','233','288','440','477','558','990','900','117','144','199','225','388','559','577','667','000','111','222','333','444','555','666','777','888','999'];

  List<String> SinglePannaSuggestionList = ['127', '136', '190', '235', '280', '279', '370', '389', '459', '460', '479', '578', '128', '137', '146', '236', '245', '290', '380', '470', '489', '560', '579', '678', '129', '138', '147', '156', '237', '246', '345', '390', '480', '570', '589', '679', '120', '139', '148', '157', '238', '247', '256', '346', '490', '580', '670', '689', '130', '149', '158', '167', '239', '248', '257', '347', '356', '590', '680', '789', '140', '159', '168', '230', '249', '258', '267', '348', '357', '456', '690', '780', '123', '150', '169', '178', '240', '259', '268', '349', '358', '457', '367', '790', '124', '160', '179', '250', '269', '278', '340', '359', '368', '458', '467', '890', '125', '134', '170', '189', '260', '279', '350', '369', '378', '459', '468', '567', '126', '135', '180', '234', '270', '289', '360', '379', '450', '469', '478', '568'];

  List<String> triplePannaSuggestionList = ['000', '111', '222', '333', '444', '555', '666', '777', '888', '999'];
  List<String> singleDigitSuggestionList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> jodiDigitSuggestionList = [for (var i = 10; i < 100; i++) i.toString().padLeft(2 , '0')];

  @override
  Future<void> onInit() async {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
