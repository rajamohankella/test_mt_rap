CLASS zcl_mt_rk_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    data lv_mode TYPE c VALUE 'C'.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mt_rk_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    CASE lv_mode.
      WHEN 'R'.
        READ ENTITIES OF zmt_rk_travel
        ENTITY Travel
        FIELDS ( TravelId BeginDate TotalPrice )
        WITH VALUE #( ( TravelId = '00000011' )
          ( TravelId = '00000015' )
           ( TravelId = '89569636' ) )
        RESULT DATA(lt_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_message).

        out->write(
          EXPORTING
            data = lt_result ).

        out->write(
          EXPORTING
            data = lt_failed ).

        out->write(
          EXPORTING
            data = lt_message ).

      WHEN 'C'.

        data(lv_description) = 'Anubhav Rocks with RAP'.
        data(lv_agency) = '070016'.
        data(lv_customer) = '000697'.

        MODIFY ENTITIES OF zmt_rk_travel
        ENTITY Travel
        CREATE FIELDS ( TravelId AgencyId CurrencyCode BeginDate EndDate Description OverallStatus )
        WITH VALUE #(
                       (
                             %CID = 'RAJAMOHAN'
                             TravelId = '11223344'
                             AgencyId = lv_agency
                             CustomerId = lv_customer
                             BeginDate = cl_abap_context_info=>get_system_date( )
                             EndDate = cl_abap_context_info=>get_system_date( ) + 30
                             Description = lv_description
                             OverallStatus = 'O'
                            )
                           ( %CID = 'RAJAMOHAN-1'
                             TravelId = '11223345'
                             AgencyId = lv_agency
                             CustomerId = lv_customer
                             BeginDate = cl_abap_context_info=>get_system_date( )
                             EndDate = cl_abap_context_info=>get_system_date( ) + 30
                             Description = lv_description
                             OverallStatus = 'O'
                            )
                            (
                             %CID = 'RAJAMOHAN-2'
                             TravelId = '00000010'
                             AgencyId = lv_agency
                             CustomerId = lv_customer
                             BeginDate = cl_abap_context_info=>get_system_date( )
                             EndDate = cl_abap_context_info=>get_system_date( ) + 30
                             Description = lv_description
                             OverallStatus = 'O'
                            )
         )
         MAPPED DATA(lt_mapped)
         FAILED DATA(lt_failed_c)
         REPORTED DATA(lt_message_c).
         COMMIT ENTITIES.

         out->write(
          EXPORTING
            data = lt_mapped ).

        out->write(
          EXPORTING
            data = lt_failed_c ).

        out->write(
          EXPORTING
            data = lt_message_c ).

      WHEN 'U'.
        lv_description = 'Wow, That was an update'.
           lv_agency = '070039'.
           MODIFY ENTITIES OF ZMT_rk_TRAVEL
           ENTITY Travel
           UPDATE FIELDS ( AgencyId Description )
           WITH VALUE #(
                           ( TravelId = '00001133'
                             AgencyId = lv_agency
                             Description = lv_description
                            )
                           ( TravelId = '00001135'
                             AgencyId = lv_agency
                             Description = lv_description
                            )
            )
            MAPPED DATA(lt_mapped_u)
            FAILED DATA(lt_failed_u)
            REPORTED DATA(lt_message_u).
            COMMIT ENTITIES.
            out->write(
             EXPORTING
               data   = lt_mapped_u
           ).
           out->write(
             EXPORTING
               data   = lt_failed_u ).
      WHEN 'D'.
        MODIFY ENTITIES OF ZMT_AB_TRAVEL
           ENTITY Travel
           DELETE FROM VALUE #(
                           ( TravelId = '00012347'
                            )
            )
            MAPPED DATA(lt_mapped_d)
            FAILED DATA(lt_failed_d)
            REPORTED DATA(lt_message_d).
            COMMIT ENTITIES.
            out->write(
             EXPORTING
               data   = lt_mapped_d
           ).
           out->write(
             EXPORTING
               data   = lt_failed_d
           ).

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
