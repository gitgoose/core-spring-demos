package com.gordondickens.jmsdemo.entity;

import com.gordondickens.jmsdemo.entity.Recipient;
import java.lang.Integer;
import java.lang.Long;
import java.lang.SuppressWarnings;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Recipient_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Recipient.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Recipient.id;
    
    @Version
    @Column(name = "version")
    private Integer Recipient.version;
    
    public Long Recipient.getId() {
        return this.id;
    }
    
    public void Recipient.setId(Long id) {
        this.id = id;
    }
    
    public Integer Recipient.getVersion() {
        return this.version;
    }
    
    public void Recipient.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Recipient.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Recipient.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Recipient attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Recipient.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public Recipient Recipient.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Recipient merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager Recipient.entityManager() {
        EntityManager em = new Recipient().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Recipient.countRecipients() {
        return ((Number) entityManager().createQuery("select count(o) from Recipient o").getSingleResult()).longValue();
    }
    
    @SuppressWarnings("unchecked")
    public static List<Recipient> Recipient.findAllRecipients() {
        return entityManager().createQuery("select o from Recipient o").getResultList();
    }
    
    public static Recipient Recipient.findRecipient(Long id) {
        if (id == null) return null;
        return entityManager().find(Recipient.class, id);
    }
    
    @SuppressWarnings("unchecked")
    public static List<Recipient> Recipient.findRecipientEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Recipient o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
