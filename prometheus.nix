{ config, pkgs, ... }: {
  services.prometheus = {
    enable = true;
    port = 9001;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "netstat" "tcpstat" "meminfo" "systemd" ];
        port = 9002;
      };
    };
    scrapeConfigs = [
      {
        job_name = "node";
#	scrape_interval = "15s";

#	metrics_path = "/federate";

	honor_labels = true;
	
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }

    ];
  };
}
