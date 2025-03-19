CLASS zcl_mt_rk_ve_calc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mt_rk_ve_calc IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    CHECK NOT it_original_data IS INITIAL.
    DATA: lt_calc_data TYPE STANDARD TABLE OF zmt_ab_travel_processor WITH DEFAULT KEY,
          lv_rate      TYPE p DECIMALS 2 VALUE '0.025'.
    lt_calc_data = CORRESPONDING #( it_original_data ).
    LOOP AT lt_calc_data ASSIGNING FIELD-SYMBOL(<fs_calc>).
      <fs_calc>-CO2Tax = <fs_calc>-TotalPrice * lv_rate.
      ""here you can call a BAPI and calculate some values and send those in VE
      <fs_calc>-dayOfTheFlight = 'Sunday'.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #(  lt_calc_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
