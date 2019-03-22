def mock_config_setting(setting, value)
	allow(HotDateRails.config)
		.to receive(setting)
		.and_return(value)
end