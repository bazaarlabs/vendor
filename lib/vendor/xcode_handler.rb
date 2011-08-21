require 'appscript'

module Vendor
  module XcodeHandler
    # Vendor::XcodeHandler.new
    def initialize(project_path)
      @app = Appscript.app('Xcode')
    end

    # @xcode.version => 4
    def version
      @version = @app.version.get.split('.')[0].to_i
    end

    # @xcode.open_project("path/to/project")
    def open_project(project_path)
      @app.open(project_path)
    end
  end # XcodeHandler
end # Vendor

=begin

Check: https://github.com/gonzoua/xcs/blob/master/xcs.thor
# TODO Remove this printout
@app.methods =>
["bounds", "target_type", "link_binary_with_libraries_phases", "minimum_count",
  "source_directories", "product_directory", "startup_directory", "real_path",
  "build_messages", "starting_page", "project_documents", "project_relative_path",
  "show_document_with_UUID", "frontmost", "schemes", "build_file", "Xcode_3_file_references",
  "build_java_resources_phase", "documents", "document", "abstract", "build_settings",
  "build_java_resources_phases", "active", "project_file_reference", "move", "workspace_documents",
  "contents", "id_", "condition", "delete", "closeable", "product_reference", "copy_headers_phases",
  "reopen", "maximum_count", "environment_variables", "indent_width", "select", "build_configuration_types",
  "launchable", "file_name", "root_group", "clean", "model_documents", "path_type", "size",
  "destination_directory", "scm_update", "active_workspace_document", "location", "text", "project_items",
  "kind", "build_styles", "color", "active_build_style", "user_info", "project_roots", "attribute_runs",
  "target_printer", "tag", "build", "enabled", "file_documents", "miniaturizable",
  "copy_bundle_resources_phases", "value", "native", "make", "relationships", "file_kind",
  "inverse_relationship", "comments", "breakpoints", "superclasses", "close", "upgrade_project_file",
  "run_only_when_installing", "class_model_documents", "localized", "show_document_with_apple_ref",
  "count", "active_blueprint_document", "full_path", "file_breakpoints", "add", "exists",
  "active_executable", "font", "text_bookmarks", "path_for_apple_ref", "path", "transient",
  "item_references", "character_range", "fax_number", "user_file_reference", "paragraphs",
  "load_documentation_set_with_path", "open_location", "build_configuration_type", "target_dependencies",
  "miniaturized", "compile_applescripts_phases", "executables", "link_binary_with_libraries_phase",
  "author", "fetch_requests", "head_revision_number", "document_or_list_of_document", "destination_entity",
  "project", "output_paths", "implementation_language", "debug", "run_script_phase", "blueprint_documents",
  "line_ending", "path_for_document_with_UUID", "active_project_document", "containers", "container",
  "selected_paragraph_range", "scm_revisions", "active_SDK", "message", "ending_page", "optional",
  "symbolic_breakpoints", "revision", "set", "windows", "error_handling", "Xcode_3_groups",
  "active_architecture", "scm_clear_sticky_tags", "flattened_build_settings", "rich_text",
  "configuration_settings_file", "executable", "version", "copy_headers_phase", "attributes",
  "build_phases", "resizable", "scm_compare", "file_or_list_of_file", "destination",
  "data_model_documents", "revision_number", "properties_", "remove", "input_paths", "hide_action",
  "line_number", "save", "launch_arguments", "leaf", "activate", "shell_path", "modified",
  "selected_character_range", "build_files", "collating", "operations", "active_target",
  "project_templates", "commit_message", "attribute_type", "active_build_configuration_type", "applications",
  "requested_print_time", "scm_commit", "build_phase", "base_build_settings", "open", "visible", "target",
  "group", "copy_bundle_resources_phase", "attachments", "build_products_relative_path", "items",
  "list_of_file_or_specifier", "predicate", "description", "source_documents", "groups",
  "default_build_configuration_type", "copy_files_phases", "hidden_per_filter", "shell_script",
  "print_settingss", "symbol_name", "launch", "active_arguments", "notifies_when_closing",
  "build_configurations", "index", "status", "RGB_color", "copies", "code_classes", "currently_building",
  "hack", "projects", "scm_transcript", "class_", "breakpoints_enabled", "variables", "uses_tabs",
  "text_documents", "pages_down", "urlstring_for_document_with_apple_ref", "compiled_code_size", "print",
  "words", "zoomable", "compile_sources_phase", "insertion_points", "get", "parent", "organization_name",
  "quit", "compile_sources_phases", "hidden_in_diagram", "urlstring_for_document_with_UUID",
  "show_environment_variables", "fetched_properties", "file_encoding", "run_script_phases", "project_member",
  "run", "editor_settings", "default_value", "documentation_configuration_changed", "bookmarks",
  "intermediates_directory", "to_many", "duplicate", "selection", "container_items", "availability",
   "upgrade", "pages_across", "target_templates", "tab_width", "scm_refresh", "file",
  "file_references", "timestamp", "file_reference", "build_resource_manager_resources_phase",
  "characters", "zoomed", "launch_", "object_class", "targets", "category", "project_directory",
  "read_only", "build_resource_manager_resources_phases", "entire_contents", "automatically_continue",
  "entities"]
=end