require_relative '../spec_helper'
require_relative '../../../lib/ruby_aem/resources/package'

require 'rexml/document'

describe 'Package' do
  before do
    @mock_client = double('mock_client')
    @package = RubyAem::Resources::Package.new(@mock_client, 'somepackagegroup', 'somepackage', '1.2.3')
  end

  after do
  end

  describe 'test create' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'create',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.create
    end
  end

  describe 'test update' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'update',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        filter: '[{"root":"/apps/geometrixx","rules":[]},{"root":"/apps/geometrixx-common","rules":[]}]'
      )
      @package.update('[{"root":"/apps/geometrixx","rules":[]},{"root":"/apps/geometrixx-common","rules":[]}]')
    end
  end

  describe 'test delete' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'delete',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.delete
    end
  end

  describe 'test install' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'install',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        recursive: false
      )
      @package.install(recursive: false)
    end
  end

  describe 'test uninstall' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'uninstall',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.uninstall
    end
  end

  describe 'test replicate' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'replicate',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.replicate
    end
  end

  describe 'test build' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'build',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.build
    end
  end

  describe 'test download' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'download',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        file_path: '/tmp'
      )
      @package.download('/tmp')
    end
  end

  describe 'test upload' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'upload',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        file_path: '/tmp',
        force: true
      )
      @package.upload('/tmp', force: true)
    end
  end

  describe 'test get_filter' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'get_filter',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.get_filter
    end
  end

  describe 'test activate_filter' do
    it 'should call client with expected parameters' do
      mock_result_get_filter = double('mock_result_get_filter')
      mock_result_activate1 = double('mock_result_activate1')
      mock_result_activate2 = double('mock_result_activate2')

      expect(mock_result_get_filter).to receive(:data).and_return(['/some/path/1', '/some/path/2'])
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'get_filter',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_get_filter)
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Path,
        'activate',
        name: '/some/path/1',
        ignoredeactivated: true,
        onlymodified: false
      ).and_return(mock_result_activate1)
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Path,
        'activate',
        name: '/some/path/2',
        ignoredeactivated: true,
        onlymodified: false
      ).and_return(mock_result_activate2)

      @package.activate_filter(true, false)
    end
  end

  describe 'test list_all' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      )
      @package.list_all
    end
  end

  describe 'test get_versions' do
    it 'should retrieve all versions when the package has multiple versions' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.4</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.get_versions
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 has 2 version(s)')
      expect(result.response).to be(nil)
      expect(result.data.length).to eq(2)
      expect(result.data[0]).to eq('1.2.3')
      expect(result.data[1]).to eq('1.2.4')
    end

    it 'should retrieve the version when the package only has one version' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.get_versions
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 has 1 version(s)')
      expect(result.response).to be(nil)
      expect(result.data.length).to eq(1)
      expect(result.data[0]).to eq('1.2.3')
    end

    it 'should retrieve empty array when the package does not exist at all' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>otherpackagegroup</group>' \
        '    <name>otherpackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.get_versions
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 has 0 version(s)')
      expect(result.response).to be(nil)
      expect(result.data.length).to eq(0)
    end
  end

  describe 'test exists' do
    it 'should return true result data when package exists on the list' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.exists
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 exists')
      expect(result.response).to be(nil)
      expect(result.data).to eq(true)
    end

    it 'should return false result data when package does not exist on the list' do
      mock_data_list_all = REXML::Document.new('')
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.exists
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 does not exist')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end
  end

  describe 'test is_uploaded' do
    it 'should return true result data when package exists on the list' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_uploaded
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is uploaded')
      expect(result.response).to be(nil)
      expect(result.data).to eq(true)
    end

    it 'should return false result data when package does not exist on the list' do
      mock_data_list_all = REXML::Document.new('')
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_uploaded
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not uploaded')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end
  end

  describe 'test is_installed' do
    it 'should return true result data when package has lastUnpackedBy attribute value' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <lastUnpackedBy>admin</lastUnpackedBy>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_installed
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is installed')
      expect(result.response).to be(nil)
      expect(result.data).to eq(true)
    end

    it 'should return false result  data when package has null lastUnpackedBy attribute value' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <lastUnpackedBy>null</lastUnpackedBy>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_installed
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not installed')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end

    it 'should return false result  data when package has null lastUnpackedBy attribute value' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <lastUnpackedBy/>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_installed
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not installed')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end

    it 'should return false result  data when checked package segment does not exist at all' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>otherpackagegroup</group>' \
        '    <name>otherpackage</name>' \
        '    <version>4.5.6</version>' \
        '    <lastUnpackedBy>admin</lastUnpackedBy>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_installed
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not installed')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end
  end

  describe 'test is_empty' do
    it 'should return true result data when package has size attribute value zero' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <size>0</size>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_empty
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is empty')
      expect(result.response).to be(nil)
      expect(result.data).to eq(true)
    end

    it 'should return false result  data when package has size attribute value non-zero' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <size>2394</size>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_empty
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not empty')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end
  end

  describe 'test is_built' do
    it 'should return true result data when package exists and not empty' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <size>30948209423</size>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).twice.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_built
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is built')
      expect(result.response).to be(nil)
      expect(result.data).to eq(true)
    end

    it 'should return false result data when package exists and empty' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <size>0</size>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).twice.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_built
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not built because it is empty')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end

    it 'should return false result data when package does not exist' do
      mock_data_list_all = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>otherpackagegroup</group>' \
        '    <name>otherpackage</name>' \
        '    <version>1.2.3</version>' \
        '    <size>23422342</size>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all = double('mock_result_list_all')
      expect(mock_result_list_all).to receive(:data).and_return(mock_data_list_all)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3'
      ).and_return(mock_result_list_all)
      result = @package.is_built
      expect(result.message).to eq('Package somepackagegroup/somepackage-1.2.3 is not built because it does not exist')
      expect(result.response).to be(nil)
      expect(result.data).to eq(false)
    end
  end

  describe 'test upload_wait_until_ready' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'upload',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        file_path: '/tmp',
        force: true,
        _retries: {
          max_tries: 60,
          base_sleep_seconds: 2,
          max_sleep_seconds: 2
        }
      )

      mock_data_list_all_not_installed = REXML::Document.new('')
      mock_result_list_all_not_installed = double('mock_result_list_all_not_installed')
      expect(mock_result_list_all_not_installed).to receive(:data).and_return(mock_data_list_all_not_installed)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        file_path: '/tmp',
        force: true,
        _retries: {
          max_tries: 60,
          base_sleep_seconds: 2,
          max_sleep_seconds: 2
        }
      ).and_return(mock_result_list_all_not_installed)

      mock_data_list_all_uploaded = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all_uploaded = double('mock_result_list_all_uploaded')
      expect(mock_result_list_all_uploaded).to receive(:data).and_return(mock_data_list_all_uploaded)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        file_path: '/tmp',
        force: true,
        _retries: {
          max_tries: 60,
          base_sleep_seconds: 2,
          max_sleep_seconds: 2
        }
      ).and_return(mock_result_list_all_uploaded)

      expect(STDOUT).to receive(:puts).with('Upload check #1: false - Package somepackagegroup/somepackage-1.2.3 is not uploaded')
      expect(STDOUT).to receive(:puts).with('Upload check #2: true - Package somepackagegroup/somepackage-1.2.3 is uploaded')

      @package.upload_wait_until_ready(
        '/tmp',
        force: true,
        _retries: {
          max_tries: 60,
          base_sleep_seconds: 2,
          max_sleep_seconds: 2
        }
      )
    end
  end

  describe 'test install_wait_until_ready' do
    it 'should call client with expected parameters' do
      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'install',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        recursive: true
      )

      mock_data_list_all_not_installed = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <lastUnpackedBy>null</lastUnpackedBy>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all_not_installed = double('mock_result_list_all_not_installed')
      expect(mock_result_list_all_not_installed).to receive(:data).and_return(mock_data_list_all_not_installed)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        recursive: true
      ).and_return(mock_result_list_all_not_installed)

      mock_data_list_all_installed = REXML::Document.new(
        '<packages>' \
        '  <package>' \
        '    <group>somepackagegroup</group>' \
        '    <name>somepackage</name>' \
        '    <version>1.2.3</version>' \
        '    <lastUnpackedBy>admin</lastUnpackedBy>' \
        '  </package>' \
        '</packages>'
      )
      mock_result_list_all_installed = double('mock_result_list_all')
      expect(mock_result_list_all_installed).to receive(:data).and_return(mock_data_list_all_installed)

      expect(@mock_client).to receive(:call).once.with(
        RubyAem::Resources::Package,
        'list_all',
        group_name: 'somepackagegroup',
        package_name: 'somepackage',
        package_version: '1.2.3',
        recursive: true
      ).and_return(mock_result_list_all_installed)

      expect(STDOUT).to receive(:puts).with('Install check #1: false - Package somepackagegroup/somepackage-1.2.3 is not installed')
      expect(STDOUT).to receive(:puts).with('Install check #2: true - Package somepackagegroup/somepackage-1.2.3 is installed')

      @package.install_wait_until_ready
    end

    describe 'test delete_wait_until_ready' do
      it 'should call client with expected parameters' do
        expect(@mock_client).to receive(:call).once.with(
          RubyAem::Resources::Package,
          'delete',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        )

        mock_data_list_all_uploaded = REXML::Document.new(
          '<packages>' \
          '  <package>' \
          '    <group>somepackagegroup</group>' \
          '    <name>somepackage</name>' \
          '    <version>1.2.3</version>' \
          '  </package>' \
          '</packages>'
        )
        mock_result_list_all_uploaded = double('mock_result_list_all_uploaded')
        expect(mock_result_list_all_uploaded).to receive(:data).and_return(mock_data_list_all_uploaded)

        expect(@mock_client).to receive(:call).once.with(
          RubyAem::Resources::Package,
          'list_all',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        ).and_return(mock_result_list_all_uploaded)

        mock_data_list_all_not_uploaded = REXML::Document.new(
          '<packages>' \
          '</packages>'
        )
        mock_result_list_all_not_uploaded = double('mock_result_list_all_not_uploaded')
        expect(mock_result_list_all_not_uploaded).to receive(:data).and_return(mock_data_list_all_not_uploaded)

        expect(@mock_client).to receive(:call).once.with(
          RubyAem::Resources::Package,
          'list_all',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        ).and_return(mock_result_list_all_not_uploaded)

        expect(STDOUT).to receive(:puts).with('Delete check #1: false - Package somepackagegroup/somepackage-1.2.3 is uploaded')
        expect(STDOUT).to receive(:puts).with('Delete check #2: true - Package somepackagegroup/somepackage-1.2.3 is not uploaded')

        @package.delete_wait_until_ready
      end
    end

    describe 'test build_wait_until_ready' do
      it 'should call client with expected parameters' do
        expect(@mock_client).to receive(:call).once.with(
          RubyAem::Resources::Package,
          'build',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        )

        mock_data_list_all_exists_but_empty = REXML::Document.new(
          '<packages>' \
          '  <package>' \
          '    <group>somepackagegroup</group>' \
          '    <name>somepackage</name>' \
          '    <version>1.2.3</version>' \
          '    <size>0</size>' \
          '  </package>' \
          '</packages>'
        )
        mock_result_list_all_exists_but_empty = double('mock_result_list_all_exists_but_empty')
        expect(mock_result_list_all_exists_but_empty).to receive(:data).and_return(mock_data_list_all_exists_but_empty)
        expect(mock_result_list_all_exists_but_empty).to receive(:data).and_return(mock_data_list_all_exists_but_empty)

        expect(@mock_client).to receive(:call).twice.with(
          RubyAem::Resources::Package,
          'list_all',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        ).and_return(mock_result_list_all_exists_but_empty)

        mock_data_list_all_exists_but_not_empty = REXML::Document.new(
          '<packages>' \
          '  <package>' \
          '    <group>somepackagegroup</group>' \
          '    <name>somepackage</name>' \
          '    <version>1.2.3</version>' \
          '    <size>9384729437</size>' \
          '  </package>' \
          '</packages>'
        )
        mock_result_list_all_exists_but_not_empty = double('mock_result_list_all_exists_but_not_empty')
        expect(mock_result_list_all_exists_but_not_empty).to receive(:data).and_return(mock_data_list_all_exists_but_not_empty)
        expect(mock_result_list_all_exists_but_not_empty).to receive(:data).and_return(mock_data_list_all_exists_but_not_empty)

        expect(@mock_client).to receive(:call).twice.with(
          RubyAem::Resources::Package,
          'list_all',
          group_name: 'somepackagegroup',
          package_name: 'somepackage',
          package_version: '1.2.3'
        ).and_return(mock_result_list_all_exists_but_not_empty)

        expect(STDOUT).to receive(:puts).with('Build check #1: false - Package somepackagegroup/somepackage-1.2.3 is not built because it is empty')
        expect(STDOUT).to receive(:puts).with('Build check #2: true - Package somepackagegroup/somepackage-1.2.3 is built')

        @package.build_wait_until_ready
      end
    end
  end
end
