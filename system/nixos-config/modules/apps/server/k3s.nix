{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    age
    docker-compose_2
    fluxcd
    git
    go-task
    htop
    jq
    k3s
    k9s
    kube-capacity
    kubectl
    nfs-utils
    openiscsi
    openssl_3
    prometheus-node-exporter
    promtail
    sops
    vim
    (python39.withPackages (p: with p; [
      cryptography
    ]))
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # the default settings of nixos are not usable in modern systems
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 524288;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288;

  security.pki.certificateFiles = [ "/opt/certs/self-signed-ca-cert.crt" ];
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  virtualisation.docker.enable = true;
  networking.firewall.allowedTCPPorts = [ 6443 10250 ];

  services.openiscsi.name = "iscsid";
  services.openiscsi.enable = true;
  services.promtail.enable = true;
  services.prometheus.exporters.node.enable = true;
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    "--disable=traefik,local-storage,metrics-server"
    "--kube-apiserver-arg='enable-admission-plugins=DefaultStorageClass,DefaultTolerationSeconds,LimitRanger,MutatingAdmissionWebhook,NamespaceLifecycle,NodeRestriction,PersistentVolumeClaimResize,Priority,ResourceQuota,ServiceAccount,TaintNodesByCondition,ValidatingAdmissionWebhook'"
  ];
}