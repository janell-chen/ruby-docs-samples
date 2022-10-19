# Copyright 2022 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative "./spec_helper"
require_relative "../spanner_delete_dml_returning"
require_relative "../spanner_update_dml_returning"
require_relative "../spanner_insert_dml_returning"

describe "Google Cloud Spanner Postgres examples" do
  before :each do
    cleanup_database_resources
    create_singers_albums_database
    insert_data project_id: @project_id,
                instance_id: @instance_id,
                database_id: @database_id
  end

  after :each do
    cleanup_database_resources
    cleanup_instance_resources
  end

  example "spanner_delete_dml_returning" do
    capture do
      spanner_delete_dml_returning project_id: @project_id,
                                   instance_id: @instance_id,
                                   database_id: @database_id
    end

    expect(captured_output).to include("Deleted singer with id: 3, FirstName: Alice")
    expect(captured_output).to include("Deleted row(s) count: 1")
  end

  example "spanner_update_dml_returning" do
    capture do
      spanner_update_dml_returning project_id: @project_id,
                                   instance_id: @instance_id,
                                   database_id: @database_id
    end

    expect(captured_output).to include("Updated Album with AlbumId: 1, SingerId: 1, AlbumTitle: Total Junk updated")
    expect(captured_output).to include("Updated row(s) count: 1")
  end

  example "spanner_insert_dml_returning" do
    capture do
      spanner_insert_dml_returning project_id: @project_id,
                                   instance_id: @instance_id,
                                   database_id: @database_id
    end

    expect(captured_output).to include("Insert singers with id: 12, FirstName: Melissa")
    expect(captured_output).to include("Insert singers with id: 13, FirstName: Russell")
    expect(captured_output).to include("Insert singers with id: 14, FirstName: Jacqueline")
    expect(captured_output).to include("Insert singers with id: 15, FirstName: Dylan")
    expect(captured_output).to include("Inserted row(s) count: 4")
  end
end
