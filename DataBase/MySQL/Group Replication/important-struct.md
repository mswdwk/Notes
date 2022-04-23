
Group_member_info(char* hostname_arg,
                    uint port_arg,
                    char* uuid_arg,
                    int write_set_extraction_algorithm,
                    const std::string& gcs_member_id_arg,
                    Group_member_info::Group_member_status status_arg,
                    Member_version& member_version_arg,
                    ulonglong gtid_assignment_block_size_arg,
                    Group_member_info::Group_member_role role_arg,
                    bool in_single_primary_mode,
                    bool has_enforces_update_everywhere_checks,
                    uint member_weight_arg,
                    uint lower_case_table_names_arg);