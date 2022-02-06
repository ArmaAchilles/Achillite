#include "../script_component.hpp"

#define GUI_GRID_X                              safeZoneX
#define GUI_GRID_Y                              safeZoneY
#define GUI_GRID_W                              (((safeZoneW / safeZoneH) min 1.2) / 40)
#define GUI_GRID_H                              (((safeZoneW / safeZoneH) min 1.2) / 30)

#define POS_X(N)                                ((N) * GUI_GRID_W)
#define POS_Y(N)                                ((N) * GUI_GRID_H)
#define POS_W(N)                                ((N) * GUI_GRID_W)
#define POS_H(N)                                ((N) * GUI_GRID_H)
#define POS(N_X, N_Y, N_W, N_H)                 [POS_X(N_X), POS_Y(N_Y), POS_W(N_W), POS_H(N_H)]

#define IDC_OK                                  1
#define IDC_CANCEL                              2

#define IDD_RSCDISPLAYATTRIBUTES                -1
#define IDC_RSCDISPLAYATTRIBUTES_BACKGROUND     30001
#define IDC_RSCDISPLAYATTRIBUTES_TITLE          30002
#define IDC_RSCDISPLAYATTRIBUTES_CONTENT        30003
#define IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM   30004

#define LABEL_BG_COLOR                          [0, 0, 0, 0.5]
#define FIELD_BG_COLOR                          [1, 1, 1, 0.1]
#define COMBO_BG_COLOR                          [0, 0, 0, 1]
