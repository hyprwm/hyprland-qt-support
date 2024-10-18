set(INSTALL_QMLDIR "${CMAKE_INSTALL_LIBDIR}/qt-6/qml")

# Install a given target as a QML module. This is mostly pulled from ECM, as there does not seem
# to be an official way to do it.
# see https://github.com/KDE/extra-cmake-modules/blob/fe0f606bf7f222e36f7560fd7a2c33ef993e23bb/modules/ECMQmlModule6.cmake#L160
function(install_qml_module arg_TARGET)
    qt_query_qml_module(${arg_TARGET}
        URI module_uri
        VERSION module_version
        PLUGIN_TARGET module_plugin_target
        TARGET_PATH module_target_path
        QMLDIR module_qmldir
        TYPEINFO module_typeinfo
        QML_FILES module_qml_files
        RESOURCES module_resources
    )

    set(module_dir "${INSTALL_QMLDIR}/${module_target_path}")

    if (NOT TARGET "${module_plugin_target}")
        message(FATAL_ERROR "install_qml_modules called for a target without a plugin")
    endif()

    install(
        TARGETS "${arg_TARGET}"
        LIBRARY DESTINATION "${module_dir}"
        RUNTIME DESTINATION "${module_dir}"
    )

    install(
        TARGETS "${module_plugin_target}"
        LIBRARY DESTINATION "${module_dir}"
        RUNTIME DESTINATION "${module_dir}"
    )

    install(FILES "${module_qmldir}" DESTINATION "${module_dir}")
    install(FILES "${module_typeinfo}" DESTINATION "${module_dir}")

    # Install QML files
    list(LENGTH module_qml_files num_files)
    if (NOT "${module_qml_files}" MATCHES "NOTFOUND" AND ${num_files} GREATER 0)
        qt_query_qml_module(${arg_TARGET} QML_FILES_DEPLOY_PATHS qml_files_deploy_paths)

        math(EXPR last_index "${num_files} - 1")
        foreach(i RANGE 0 ${last_index})
            list(GET module_qml_files       ${i} src_file)
            list(GET qml_files_deploy_paths ${i} deploy_path)
            get_filename_component(dst_name "${deploy_path}" NAME)
            get_filename_component(dest_dir "${deploy_path}" DIRECTORY)
            install(FILES "${src_file}" DESTINATION "${module_dir}/${dest_dir}" RENAME "${dst_name}")
        endforeach()
    endif()

    # Install resources
    list(LENGTH module_resources num_files)
    if (NOT "${module_resources}" MATCHES "NOTFOUND" AND ${num_files} GREATER 0)
        qt_query_qml_module(${arg_TARGET} RESOURCES_DEPLOY_PATHS resources_deploy_paths)

        math(EXPR last_index "${num_files} - 1")
        foreach(i RANGE 0 ${last_index})
            list(GET module_resources       ${i} src_file)
            list(GET resources_deploy_paths ${i} deploy_path)
            get_filename_component(dst_name "${deploy_path}" NAME)
            get_filename_component(dest_dir "${deploy_path}" DIRECTORY)
            install(FILES "${src_file}" DESTINATION "${module_dir}/${dest_dir}" RENAME "${dst_name}")
        endforeach()
    endif()
endfunction()
