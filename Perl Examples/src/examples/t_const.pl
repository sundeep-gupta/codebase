use constant ALLOWED_PL_FILES => { map { $_ => 1 }
    qw(addquotes.pl add_txk_level.pl any2unix.pl
       apf_check_header_files.pl apf_create_baseline.pl apf.pl
       apf_pseudo_translator.pl apf_pull.pl apf_truss.pl
       aru_apf_delete_object.pl ARUBUGTR.pl aru_checkin.pl
       bug_alert_cron.pl build_search_indexes.pl cache_state.pl
       cleanup_nlsftpd.pl convert_bdp_to_bip.pl
       create_R12_build_top.pl db_backup.pl db_control.pl
       db_refresh.pl dra_aggrmgt.pl dra_napapi.pl dra_qtreemgt.pl
       dra_snapmgt.pl dra_storage_dispatcher.pl dra_volmgt.pl
       DriverGen.pl ems_bootup.pl ems_check_daemon.pl
       ems_create_filer_accounts.pl ems_diskless_startup.pl
       ems_generate_tns.pl ems_gridctl.pl ems_handle_stale_nfs.pl
       ems_sync_sudoers.pl ems_validate_node.pl forms_hwm.pl
       generate_ildt.pl get_bug_components.pl gscc_build_config.pl
       gscc_build_reports.pl gscc_create_standards.pl
       gscc_result_upload.pl gscc_run_engine.pl gscc_run_sync.pl
       gscc_update_efc_versions.pl isd_cli_demo.pl
       isd_devdb_rename_db.pl java110.pl load_baseline.pl
       load_checkin.pl load_dependencies.pl load_file_drivers.pl
       package_aruconnect.pl pl2xliff.pl pts_add_responsibility.pl
       pts_admin_functions.pl pts_adworkchk.pl pts_apply_patch.pl
       pts_autopatch11.pl pts_autopatch.pl pts_cleanup.pl pts.pl
       pts_runadx.pl pts_runadx_wrap.pl pts_setcron.pl
       pull_checkin_source.pl recreate_table.pl runadpatch.pl
       schema2html.pl scs_bug_autolog.pl scs_bug_report.pl
       scs_demo_update_prodlinks.pl scs_fork.pl scs_setup_cvsroot.pl
       scs_verify_demo_psa.pl serverctl.pl tail.pl upgrade_apfwkr.pl
       upgrade.pl upload_checkin.pl url_sender.pl xml2html.pl
       zip2xliff.pl)};
use Data::Dumper;
print Dumper ALLOWED_PL_FILES;