// SPDX-License-Identifier: UNLICENSED

// Déclaration du contrat CrowdFunding
pragma solidity ^0.8.9;

contract CrowdFunding {

     // Définition de la structure Campaign pour stocker les informations sur chaque campagne de financement participatif
    struct Campaign {
        
        // Adresse du propriétaire de la campagne
        address owner;

        // Titre de la campagne
        string title;

        // Description de la campagne
        string description;

         // Montant cible de la campagne
        uint256 target;

        // Date limite de la campagne
        uint256 deadline;

         // Montant collecté jusqu'à présent
        uint256 amountCollected;

         // URL de l'image de la campagne
        string image;

        // Liste des adresses des donateurs
        address[] donators;

        // Liste des montants des dons
        uint256[] donations;
    }

    // Table de hachage qui associe un identifiant de campagne à une structure Campaign
    mapping(uint256 => Campaign) public campaigns;

    // Nombre total de campagnes créées jusqu'à présent
    uint256 public numberOfCampaigns = 0;

    // Fonction qui permet à un utilisateur de créer une nouvelle campagne de financement participatif
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {

         // Récupération de la structure Campaign associée à numberOfCampaigns
        Campaign storage campaign = campaigns[numberOfCampaigns];

         // Vérification que la date limite de la campagne est dans le futur
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        // Attribution des valeurs de la nouvelle campagne à la structure Campaign récupérée
        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        // Incrémentation du nombre de campagnes créées jusqu'à présent
        numberOfCampaigns++;

        // Retourne l'identifiant de la nouvelle campagne créée
        return numberOfCampaigns - 1;
    }

     // Fonction qui permet à un utilisateur de faire un don à une campagne de financement participatif
    function donateToCampaign(uint256 _id) public payable {

        // Stockage du montant du don dans une variable locale
        uint256 amount = msg.value;

        // Récupération de la structure Campaign associée à l'identifiant de la campagne
        Campaign storage campaign = campaigns[_id];

        // Ajout de l'adresse du donneur à la liste des donateurs de la campagne
        campaign.donators.push(msg.sender);

        // Ajout du montant du don à la liste des dons de la campagne
        campaign.donations.push(amount);

        // Transfert du montant du don au propriétaire de la campagne
        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        // Vérification que le transfert a bien été effectué
        if(sent) {

            // Ajout du montant du don au montant collecté de la campagne
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    // Fonction qui retourne la liste des donateurs et des montants des dons pour une campagne de financement participatif donnée
    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {

        // Retourne la liste des donateurs et des montants des dons pour la campagne correspondant à l'identifiant _id
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    // Fonction qui retourne la liste de toutes les campagnes de financement participatif créées jusqu'à présent
    function getCampaigns() public view returns (Campaign[] memory) {

        // Déclare un tableau de la structure Campaign avec une taille égale à numberOfCampaigns
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        // Boucle qui parcourt toutes les campagnes créées jusqu'à présent
        for(uint i = 0; i < numberOfCampaigns; i++) {

            // Récupération de la structure Campaign associée à l'identifiant i
            Campaign storage item = campaigns[i];

            // Ajout de la structure Campaign récupérée au tableau allCampaigns
            allCampaigns[i] = item;
        }

        // Retourne la liste de toutes les campagnes créées jusqu'à présent
        return allCampaigns;
    }
}